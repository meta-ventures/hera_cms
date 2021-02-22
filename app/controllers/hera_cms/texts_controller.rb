require_dependency "hera_cms/application_controller"

module HeraCms
  class TextsController < ApplicationController

    def update
      @text = HeraCms::Text.find(params[:id])

      if @text.update(text_params)
        render json: { redirect: URI(request.referer).path }, status: 200
      else
        render json: { errors: @text.errors.full_messages }, status: 422
      end
    end

    private

    def text_params
      params.require(:text).permit(:identifier, :inner_text, :classes, :style)
    end
  end
end
