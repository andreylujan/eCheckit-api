class ProductsController < ApplicationController

    
    def index
        products = Product.order(:name).each do |p|
            p.name
        end
        if params[:min_price].present?
            products = products.where("price > ?", params[:min_price])
        end

        
        render json: products
    end

    def show
        product = Product.find(params[:id])
        render json: product
    end

    def destroy
        product = Product.find(params[:id])
        product.destroy
        render nothing: true, status: :no_content
    end

    def create
        product = Product.new(params.require(:product).permit(:price, :name))
        if product.save
            render json: product, status: :created
        else
            render json: product, status: :unprocessable_entity
        end
    end

    def update
        product = Product.find(params[:id])
        if product.update_attributes(params.require(:product).permit(:price, :name))
            render json: product, status: :ok
        else
            render json: product, status: :unprocessable_entity
        end
    end

end
