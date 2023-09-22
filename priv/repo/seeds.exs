alias RentCars.Accounts

%{
  first_name: "acme",
  last_name: "foo",
  user_name: "acme_foo",
  email: "acme_foo@mail.com",
  driver_license: "123456",
  password: "12345678",
  password_confirmation: "12345678",
  role: "USER"
}
|> Accounts.create_user()

%{
  first_name: "admin",
  last_name: "foo",
  user_name: "admin",
  email: "admin_foo@mail.com",
  driver_license: "123007",
  password: "12345678",
  password_confirmation: "12345678",
  role: "ADMIN"
}
|> Accounts.create_user()
