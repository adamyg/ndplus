import abc.test.ClassTest;

/**
 * abc.data.Input TODO:...
 *
 * @usage <pre>
 *
 * </pre>
 *
 * @example <pre>
 *
 * </pre>
 *
 * @author someone
 * @verson 1.0
 */
class abc.data.Input {
       
        private var name : String;
       
        private var id : Number;
       
        private var date : Date;
       
        private var created : Boolean;
       
       
        /**
         * Input TODO:...
         *
         * @param name - TODO:...
         * @param id - TODO:...
         * @param date - TODO:...
         */
        public function Input(name : String, id : Number, date : Date) {
                init(name, id, date);
                this.created = false;
                createRecord();
        }
       
       
        /**
         * init TODO:...
         *
         * @param name - TODO:...
         * @param id - TODO:...
         * @param date - TODO:...
         *
         * @return Object TODO:...
         */
        private function init(name : String, id : Number, date : Date) : Object {
                this.date = date;
                this.id = id;
                this.name = name;
        }
       
       
        /**
         * createRecord TODO:...
         */
        private function createRecord() {
                if(!created) {
                        Record.sendData(id, date, name);
                }
        }
       
       
        /**
         * toString TODO:...
         *
         * @param Void - TODO:...
         *
         * @return String TODO:...
         */
        public function toString() : String {
                return "Input";
        }
}
