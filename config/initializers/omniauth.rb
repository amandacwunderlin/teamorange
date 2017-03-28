Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['UqLGqiUxZoNKb3LxlfqaOToKd'], ENV['PNQqPbYQP72I1nT6X0LmHhgtdilUiAT2D3RyaHiEiiGEzyaD56']
end