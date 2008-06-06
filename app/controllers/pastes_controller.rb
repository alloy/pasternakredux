class PastesController < ApplicationController
  allow_access :all
  
  def create
    return redirect_to(new_paste_url) unless params[:patch_style] == 'monkeypatch'
    
    @paste = Paste.new(params[:paste])
    if @paste.save
      redirect_to paste_url(@paste)
    end
  end
end
