class Product < ActiveRecord::Base

    validates_presence_of :price
    before_save :generate_name

    def generate_name
        self.name = self.name + " " + self.price.to_s
    end

    def name_price
        {
            hola: name + " " + price.to_s
        }
    end
end
