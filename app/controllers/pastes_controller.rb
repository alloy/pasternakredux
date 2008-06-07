class PastesController < ApplicationController
  allow_access :all
  
  def new
    @paste = Paste.new
  end
  
  def create
    return redirect_to(new_paste_url) unless params[:patch_style] == 'monkeypatch'
    
    @paste = Paste.new(params[:paste])
    if @paste.save
      redirect_to paste_url(@paste)
    end
  end
  
  def show
    @paste = Paste.find(params[:id])
    respond_to do |format|
      format.html
      format.text { render :text => @paste.code }
    end
  end
end
