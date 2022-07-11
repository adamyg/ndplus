###############################################################################
#
#   Package: NaturalDocs::Builder::ManWrap
#
###############################################################################
#
#   A package that generates output in MANDOC format.
#   The mandoc UNIX manpage compiler toolset, see ttp://mdocml.bsd.lv/
#
###############################################################################

# Copyright (C) 2014-2022 Adam Young
# Natural Docs is licensed under the GPL

use strict;

package NaturalDocs::Builder::ManWrap;

#   Function:   Format
#       Format the specified paragraph into one or more lines of width in characters.
#
#   Parameters:
#       width - Line width.
#       text - Paragraph text.
#
#   Returns:
#       ArrayRef of strngs.
#
sub
Format($$)          # (width, text)
{
    my ($width, $text) = @_;
    my @lines = ();

    if (_textlen($text) <= $width)
        {                                       # simple case.
        push @lines, $text;
        }
    else
        {
        my @words = split(/\s+/, $text);        # split by words.
        my $line = '';
        my $ll = 0;

        while (scalar @words)
            {
            my $word = shift @words;
            my $wl = _textlen($word);

            if (($ll + $wl) <= $width)
                {                               # concat word.
                    if ($ll && ($word =~ /^[(]?see:$/i || $word =~ /^see$/i) &&
                            ($ll + $wl + 1 + _textlen($words[0])) > $width)
                        {                       # dont break [(]See[:] <xxxxx>[)] references
                        unshift @words, $word;
                        push @lines, $line;
                        $line = '';
                        $ll = 0;
                        next;
                        }
                $line .= $word . ' ';
                $ll += $wl + 1;
                }
            else
                {                               # complete line.
                if ($ll)
                    {
                    $line =~ s/ $//g;
                    push @lines, $line;
                    }

                if ($wl <= $width)
                    {                           # new line.
                    $line = $word . ' ';
                    $ll = $wl + 1;
                    }
                else
                    {                           # break.
                    my @subwords = split(/[-_;,]/, $word);

                    if (scalar @subwords > 0)
                        {                       # hyphen break.
                        my $sublen = 0; 

                        $wl = 0;
                        while (defined ($_ = shift @subwords)) {
                            $wl += _textlen($_) + 1;
                            last if ($wl > $width);
                            $sublen += length($_) + 1;
                        }

                        if ($sublen > 0) 
                            {
                            $line = substr($word, 0, $sublen);
                            $ll = _textlen($line);
                            unshift @words, substr($word, $sublen);
                            next;
                            }
                        }

                                                # hard break.
                    $line = substr($word, 0, $width);
                    $ll = _textlen($line);
                    unshift @words, substr($word, $width);
                    }
                }
            }

        if ($ll)
            {
            $line =~ s/ $//g;
            push @lines, $line;
            }
        }

    return @lines;
}


#   Function:   _textlen
#       Determine the length of the cooked MANDOC text.
#
#   Parameters:
#       str - Word text.
#
#   Returns:
#       Length of the cooked MANDOC text in characters.
#
sub
_textlen($)         #(text)
{
    my $text = shift;

    return 0 
        if (!defined $text);
                                                        # html links
    $text =~ s{<img mode=\"link\" target=\"([^\"]*)\" original=\"([^\"]*)\">}{<$2>}g;
    $text =~ s{<link target=\"[^\"]*\" name=\"([^\"]*)\" original=\"[^\"]*\">}{<$1>}g;
    $text =~ s{<url target=\"[^\"]*\" name=\"([^\"]*)\">}{$1}g;

    $text =~ s/<\/?[biud]>//g;                          # html markups
    $text =~ s/&[A-Za-z]{2,3}+;/x/g;                    # htmp characters

    return length($text);
}

1;

#end
