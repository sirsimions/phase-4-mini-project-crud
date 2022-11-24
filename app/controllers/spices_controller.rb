class SpicesController < ApplicationController
    def index
        spices = Spice.all
        render json: spices
    end

    def create
        spice = Spice.create(spice_params)
        render json: spice, status: :created
        rescue ActiveRecord::RecordInvalid => invalid
        render json: { error: invalid.record.errors.full_messages}
    end

    def update
        spice = Spice.find_by(id: params[:id])
        if spice
            spice.update(spice_params)
            render json: spice, status: :accepted
        else
            render json: { error: "Spice not found"}, status: :not_found
        end
    end

    def destroy
        spice = Spice.find_by(id: params[:id])
        if spice
            spice.destroy
            render json: {}, status: 420
        else
            render json: { error: "Spice not found"}, status: :not_found
        end
    end


    private

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)

    end
end
