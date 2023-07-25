defmodule RentCars.CategoriesTest do
  use RentCars.DataCase
  alias RentCars.Categories

  test "list_categories/0 list all categories" do
    assert Categories.list_categories() == []
  end
end
