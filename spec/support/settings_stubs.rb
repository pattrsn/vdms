module SettingsStubs
  def stub_settings
    @settings = Settings.instance
    Settings.stub(:instance).and_return(@settings)
  end

  def stub_divisions(division_names)
    stub_settings if @settings.nil?
    @settings.stub(:divisions).and_return(division_names)
  end

  def stub_areas(area_names)
    stub_settings if @settings.nil?
    @settings.stub(:areas).and_return(area_names)
  end

  def unstub_settings
    @settings.destroy
    @settings = nil
    Settings.unstub(:instance)
  end
end

