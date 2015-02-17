###############################################################################
#
#   Package: NaturalDocs::Builder::ManTable
#
###############################################################################
#
#   A package that generates table output for MANDOC format.
#
###############################################################################

# This file is part of Natural Docs, which is
# Copyright (C) 2014-2015 Adam Young
# Natural Docs is licensed under the GPL

use strict;

package NaturalDocs::Builder::ManTable;

use NaturalDocs::Builder::ManWrap;

sub
New()               # ([field, ...)
{
    my ($class, @fields) = @_;
    my $strm = '';
    my $self = {
            headers     => [],                  # column headers.
            setwidths   => [],                  # lower width of cell (SetWidth()).
        ##  fixwidths   => [],                  # fixed column width.
            hdrwidths   => [],                  # width of header cells.
            maxwidths   => [],                  # upper width of cell.
            widths      => [],                  # active cell width.
            rows        => [],                  # row cell data.
            rowfmt      => '',                  # row format specification.
            separator   => 0,
            strm        => \$strm
            };
    bless $self, $class;
    return $self;
}


sub
Add                 # (text)
{
    my ($self) = shift;
    my $fieldno = 0;
    my $row = 0;

    unless (scalar @{$self->{headers}})
        { $fieldno = scalar @_ - 1; }
    else
        { $fieldno = scalar @{$self->{headers}} - 1; }

    my $maxwidths = $self->{maxwidths};
    my $cells = [ ];

    foreach my $col (0 .. $fieldno)
        {
        my $value = shift;
        my @lines;

        if (defined $value)
            {
            my $maxwidth = $maxwidths->[$col];
            my @parts = split("<br>|[\n\e]", $value);
            my $cnt = scalar @parts;
            my $compact = 1;

            foreach my $line (@parts)
                {
                $line =~ s/\s+$//;
                if (length($line))
                    {
                    if ($line eq "\fStart")
                        { 
                        push @lines, '';
                        $compact = 1;
                        }
                    elsif ($line eq "\fEnd")
                        {
                        $compact = 0;
                        }
                    else
                        {
                        my $width = length $line;
                        $maxwidth = $width
                            if (!$maxwidth or $width > $maxwidth);
                        push @lines, $line;
                        push @lines, ''
                            if (!$compact && $cnt);
                        }
                    }
                --$cnt;
                }

            $maxwidths->[$col] = $maxwidth
                if ($maxwidth);
            }
        push @$cells, \@lines;
        }

    unless (scalar @{$self->{headers}})
        {
        my $hdrwidths = $self->{hdrwidths};
        foreach my $col (0 .. $fieldno)
            {
            $hdrwidths->[$col] = $maxwidths->[$col];
            }
        $self->{headers} = $cells;
        }
    else
        {
        push @{$self->{rows}}, $cells;
        }
}


sub
SetSeperator()      # ()
{
    my ($self) = @_;

    $self->{separator} = 1;
}


sub
SetWidth($$)        # (col, width)
{
    my ($self, $col, $width) = @_;

    if (defined $width && $width > 0)
        {
        $self->{setwidths}->[$col-1] = int($width);
        }
}


sub
Export(;$$$)        # ([width], [mandoc], [blank])
{
    my ($self, $width, $mandoc, $blank) = @_;
    my $strm = $self->{strm};

    $mandoc = 1                                 # MANDOC mode (enable by default)
        if (! defined $mandoc);

    $blank = 1                                  # blabk row separator (enable by default)
        if (! defined $blank);

    if ($self->{rows})
        {
        my $rows = scalar @{$self->{rows}};
        my $row = 0;

        $self->_export_init($width);
        if ($mandoc)                            # MANDOC native tbl format.
            {
            $$strm .= "\n.TS\n";
            $self->_export_layout();
            $self->_export_data(0, $self->{headers});
            $$strm .= "=\n";
            foreach (@{$self->{rows}})
                {
                $self->_export_data(++$row, $_);
                if ($blank)
                    {
                    $self->_export_data($row, undef)
                        if (--$rows);
                    }
                }
            $$strm .= "=\n";
            $$strm .= ".TE\n";
            $$strm .= ".Pp\n";
            }
        else                                    # otherwise plain text.
            {
            $$strm .= "\n\fStart";
            $self->_export_row(0, $self->{headers});
            $self->_export_delimit();
            foreach (@{$self->{rows}})
                {
                $self->_export_row(++$row, $_);
                if ($blank)
                    {
                    $self->_export_row($row, undef)
                        if (--$rows);
                    }
                }
            $self->_export_delimit();
            $$strm .= "\n\fEnd\n";          
            }
        }

    return $$strm;
}


#   Function:   _export_init
#       Initialise table export.
#
#   Parameters:
#       totalwidth - Optional table width.
#
#   Returns:
#       nothing
#
sub
_export_init(;$)    # ([totalwidth])
{
    my ($self, $totalwidth) = @_;
    my $strm = $self->{strm};
    my $fieldno = scalar @{$self->{headers}} - 1;

    # assign column widths
    my $setwidths = $self->{setwidths};
    my $hdrwidths = $self->{hdrwidths};
    my $maxwidths = $self->{maxwidths};
    my $widths    = $self->{widths};
    my $curwidth  = 0;                          # current lower width.

    my $strm = $self->{strm};

    foreach my $col (0 .. $fieldno)
        {
        my $setwidth = $setwidths->[$col];
        my $maxwidth = $maxwidths->[$col];
        my $width =                             # assign column width.
            (defined $setwidth && $setwidth > 0 ? $setwidth : $maxwidth);

        $widths->[$col] = $width;
        $curwidth += $width;
        }

    if (defined $totalwidth && $totalwidth > 0)
        {                                       # reassign column widths (left -> right).
        my $newwidth = 0;

        if ($widths->[$fieldno] > ($totalwidth/3))
            {                                   # shortest last column to 33%.
            my $adjust = $widths->[$fieldno] - ($totalwidth/3);

            $widths->[$fieldno] -= $adjust;
            $curwidth -= $adjust;
            }

        if ($totalwidth > $curwidth)
            {
            foreach my $col (0 .. $fieldno)
                {
                my $setwidth = $setwidths->[$col];
                my $maxwidth = $maxwidths->[$col];
                my $hdrwidth = $hdrwidths->[$col];
                my $width = $widths->[$col];

                if ($width < $maxwidth)
                    {
                    if ($col == $fieldno)
                        {                       # trailing column, assign remaining.
                        my $remaining = int($totalwidth - $newwidth);
                        if ($remaining > $width)
                            {
                            $width = ($remaining > $maxwidth ? $maxwidth : $remaining);
                            }
                        }
                    elsif (int($width * 1.25) >= $maxwidth)
                        {                       # allow 25% expansion.
                        $width = $maxwidth + 1;
                        }
                    else
                        {                       # fixed %% of available.
                        my $spead = int(((1.0 * $totalwidth) - $curwidth) / ($fieldno + 1));

                        if (($width += $spead) > $maxwidth)
                            {
                            $width = $maxwidth + 1;
                            }
                        }
                    }
                else
                    {                           # reduce min(max,hdr)
                    $width = (defined $hdrwidth &&
                        $hdrwidth > $maxwidth ? $hdrwidth : $maxwidth);
                    };

                $widths->[$col] = $width;

                if (($newwidth += $width) >= $totalwidth)
                    {
                    if ($col == $fieldno)
                        {                       # trailing column
                        my $width50 = int($width * 0.5);

                        $newwidth -= $width;

                        $width50 = $hdrwidth
                            if (defined $hdrwidth && $hdrwidth > $width50);

                        $widths->[$col] =
                            (($newwidth + $width50) >= $totalwidth ? $width50 : $totalwidth - $newwidth);
                        }
                    last;
                    }
                };
            };
        };

    # build column definitions
    my $separator = $self->{separator};
    my $widths    = $self->{widths};
    my $delimit   = "\n";
    my $rowfmt    = "\n";

    foreach my $col (0 .. $fieldno)
        {
        my $width = $widths->[$col];

        if ($separator)
            {
            $rowfmt  .= '| %-' . $width . 's ';
            $delimit .= '|' . ('-' x ($width + 2));
            }
        else
            {
            $rowfmt  .= ' %-' . $width . 's ';
            $delimit .= ('-' x ($width + 2));
            }
        }

    if ($separator)
        {
        $rowfmt .= '|';
        $delimit .= '|';
        }

    $self->{rowfmt} = $rowfmt;
    $self->{delimit} = $delimit;
}


#   Function:   _export_layout.
#       MANDOC layout exporter.
#
#   Parameters:
#       none
#
#   Returns:
#       nothing
#
sub
_export_layout()    # ()
{
    my ($self) = @_;
    my $fieldno = scalar @{$self->{headers}} - 1;
    my $strm = $self->{strm};

    $$strm .=
        "l" . (" l" x $fieldno) . ".\n";
}


#   Function:   _export_data
#       MANDOC row exporter.
#
#   Parameters:
#       row - Row index.
#       headers - Columns definition.
#
#   Returns:
#       nothing
#
sub
_export_data($$)    # (row, headers)
{
    my ($self, $row, $headers) = @_;
    my ($cells, $rowno) = $self->_textcells($row, $headers);
    my $fieldno = scalar @{$self->{headers}} - 1;
    my $strm = $self->{strm};

    foreach my $r (0 .. $rowno)
        {
        foreach my $col (0 .. $fieldno)
            {
            my $lines = $cells->[$col];

            $$strm .= "\t" if ($col);
            $$strm .= (defined $lines && $r < scalar @$lines ? $lines->[$r] : '');
            }
        $$strm .= "\n";
        }
}


#   Function:   _export_delimit
#       Native row delimiter.
#
#   Parameters:
#       none
#
#   Returns:
#       nothing
#
sub
_export_delimit     # ()
{
    my ($self) = @_;
    my $strm = $self->{strm};

    $$strm .= $self->{delimit};
}


#   Function:   _export_row
#       Native row exporter.
#
#   Parameters:
#       row - Row index.
#       headers - Columns definition.
#
#   Returns:
#       nothing
#
sub
_export_row($$)     # (row, headers)
{
    my ($self, $row, $headers) = @_;
    my ($cells, $rowno) = $self->_textcells($row, $headers);
    my $fieldno = scalar @{$self->{headers}} - 1;
    my $strm = $self->{strm};

    foreach my $r (0 .. $rowno)
        {
        my @rowcells;
        foreach my $col (0 .. $fieldno)
            {
            my $lines = $cells->[$col];

            push @rowcells,
                (defined $lines && $r < scalar @$lines ? $lines->[$r] : '');
            }
        $$strm .= sprintf $self->{rowfmt}, @rowcells;
        }
}


#   Function:   _textcells
#       Cell formattting.
#
#   Parameters:
#       row - Row index.
#       headers - Columns definition.
#
#   Returns:
#       (ArrayRef of cells, rowno)
#
sub
_textcells($$)     # (row, headers)
{
    my ($self, $row, $headers) = @_;
    my $fieldno = scalar @{$self->{headers}} - 1;
    my $maxwidths = $self->{maxwidths};
    my $widths = $self->{widths};
    my @formattedcells;
    my $rowno = 0;

    if (defined $headers)
        {
        foreach my $col (0 .. $fieldno)
            {
            my $lines = $headers->[$col];
            my $maxwidth = $maxwidths->[$col];
            my $width = $widths->[$col];
            my $height;

            if (defined $maxwidth && $width < $maxwidth)
                {                               # apply column boundaries
                my @formattedlines;
                foreach (@$lines)
                    {
                    push @formattedlines,
                        NaturalDocs::Builder::ManWrap::Format($width, $_);
                    }
                push @formattedcells, \@formattedlines;
                $height = (scalar @formattedlines) - 1;
                }
            else
                {                               # native
                push @formattedcells, $lines;
                $height = (scalar @$lines) - 1;
                }

            $rowno = $height
                if ($rowno < $height);
            }
        }
    return (\@formattedcells, $rowno);
}

1;

#end
