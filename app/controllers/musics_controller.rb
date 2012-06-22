class MusicsController < InheritedResources::Base
  belongs_to :album

  def destroy
    destroy!{ album_path(@album) }
  end

end
