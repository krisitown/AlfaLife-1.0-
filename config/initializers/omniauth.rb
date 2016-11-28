Rails.application.config.middleware.use OmniAuth::Builder do 
  provider :google, ENV['479883742170-p6h1fch229fkgurl7p0lp4vvuj1of39t.apps.googleusercontent.com'], ENV['t-Wdt-qx_PtVSbHIB2wmuBcl']
end