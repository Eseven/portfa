class Dashboard::SiteAssetsController < Dashboard::DashboardController
  respond_to :html, :js
  def index
    render locals: { site_assets: site_assets }
  end

  def new
    site_asset.name = 'new_asset'
    site_asset.extension = 'css'
    respond_with site_asset
  end

  def create
    site_asset.save(site_asset_params)
    respond_with site_asset, location: resource_path
  end

  def edit
    respond_with site_asset
  end

  def update
    site_asset.update(site_asset_params)
    respond_with site_asset, location: dashboard_site_assets_path
  end

  def destroy
    site_asset.destroy
    redirect_to dashboard_site_assets_path
  end

  protected

  def site_assets
    @site_assets ||= site.site_assets
  end

  def site_asset
    @site_asset ||= begin
      params[:id] and site.site_assets.find(params[:id]) or site.site_assets.new(site_asset_params)
    end
  end

  def site_asset_params
    return {} unless params[:site_asset].present?
    params.require(:site_asset).permit(:file_name, :content)
  end

  def resource_path
    site_asset.persisted? ? edit_dashboard_site_asset_path(site_asset) : dashboard_site_assets_path
  end
end
