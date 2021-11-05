module Response
  def multi_response(object)
    respond_to do |format|
      format.html
      format.json { render json: object }
    end
  end

  def json_response(object)
    render json: object
  end
end
