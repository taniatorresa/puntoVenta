module Reports
  class Reports::SalesController < ApplicationController
    before_action :authenticate_user!
    include SalesHelper
    def index
    year = params[:y]
    month = params[:m]
    day = params[:d]
    sucursal_id = params[:s]
    usuario_id = params[:u]

      if    !sucursal_id.empty? &  !usuario_id.empty?
            @sale = Sale.where(created_at: helper_filter_beginning(year,month,day,sucursal_id)...helper_filter_ending(year,month,day,sucursal_id),company_id:sucursal_id,user_id:usuario_id)  
      elsif sucursal_id.empty? &  !usuario_id.empty?

            @sale = Sale.where(created_at: helper_filter_beginning(year,month,day,sucursal_id)...helper_filter_ending(year,month,day,sucursal_id),user_id:usuario_id)  
      elsif !sucursal_id.empty? &  usuario_id.empty?

            @sale = Sale.where(created_at: helper_filter_beginning(year,month,day,sucursal_id)...helper_filter_ending(year,month,day,sucursal_id),company_id:sucursal_id) 
      else
            @sale = Sale.where(created_at: helper_filter_beginning(year,month,day,sucursal_id)...helper_filter_ending(year,month,day,sucursal_id))
      end
   
    end

    def new
      @sale = RptSale.new
    end
    
    def create
      @sale = RptSale.new params['/reports/sales']
      redirect_to reports_sales_path(  y: params['/reports/sales'][:year], 
                                       m: params['/reports/sales'][:mes],
                                       d: params['/reports/sales'][:dia],
                                       s: params['/reports/sales'][:sucursal_id],
                                       u: params['/reports/sales'][:usuario_id])
    end
  end
end
