require_dependency "hera_cms/application_controller"
require 'json'

module HeraCms
  class LinksController < ApplicationController
    # layout "admin"

    # def index
    #   link_json = HeraCms::Link.read_json
    #   @seed_link = JSON.pretty_generate(link_json)
    #   @links = HeraCms::Link.all.order(created_at: :desc)
    # end

    # def edit
    #   @link = HeraCms::Link.find(params[:id])
    # end

    def update
      @link = HeraCms::Link.find(params[:id])

      if @link.update(link_params)
        render json: { redirect: URI(request.referer).path }, status: 200
      else
        render json: { errors: @link.errors.full_messages }, status: 422
      end
    end

    # def new
    #   @link = HeraCms::Link.new
    # end

    # def create
    #   @link = HeraCms::Link.new(link_params)

    #   @link[:translated_text] << translate_service.mount_translation(params[:link]["inner_text"])

    #   if @HeraCms::link.save
    #     redirect_to URI(request.referer).path
    #   else
    #     render :new
    #   end
    # end

    # def destroy
    #   @link = HeraCms::Link.find(params[:id])
    #   @HeraCms::link.destroy
    #   redirect_to URI(request.referer).path
    # end

    private

    def link_params
      params.require(:link).permit(:identifier, :classes, :style, :path)
    end
  end
end
