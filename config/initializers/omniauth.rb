Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter,"Consumer key","Consumer secret"
  provider :facebook,"396351487111700","87bbb3ab22c7537bf572fa994eda7e07"
end
