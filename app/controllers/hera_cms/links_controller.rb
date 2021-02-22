require_dependency "hera_cms/application_controller"

module HeraCms
  class LinksController < ApplicationController

    def update
      @link = HeraCms::Link.find(params[:id])

      if @link.update(link_params)
        render json: { redirect: URI(request.referer).path }, status: 200
      else
        render json: { errors: @link.errors.full_messages }, status: 422
      end
    end

    private

    def link_params
      params.require(:link).permit(:identifier, :classes, :style, :path, :inner_text)
    end
  end
end
