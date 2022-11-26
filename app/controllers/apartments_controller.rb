class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        render json: Apartment.all
      end
    
      def show
        apartment = find_apartment
        render json: apartment
      end
    
      def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
      end

      def update
        apartment = find_apartment
        apartment.update!(apartment_params)
        render json: apartment, status: :updated
      end

      def destroy
        apartment = find_apartment
        apartment.destroy
        head :no_content
      end
    
      private
    
      def apartment_params
        params.permit(:number)
      end
      
      def find_apartment
        Tenant.find(params[:id])
      end
    
      def render_not_found_response
        render json: { error: "Apartment not found" }, status: :not_found
      end
    
      def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
      end
    
end
