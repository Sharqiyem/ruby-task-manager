Before do
  User.create!(email: 's@s.com', password: '123456') unless User.exists?(email: 's@s.com')
end