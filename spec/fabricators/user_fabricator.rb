Fabricator(:user) do
  profile
  guildhall {Fabricate(:guildhall, name: "Dan's Guild") }
end
