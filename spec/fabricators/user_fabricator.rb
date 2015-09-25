Fabricator(:user) do
  email("dan@example.com")
  password("pass")
  password_confirmation("pass")
  profile
  guildhall {Fabricate(:guildhall, name: "Dan's Guild") }
end
