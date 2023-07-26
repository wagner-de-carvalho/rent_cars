defmodule RentCarsWeb.Api.SpecificationView do
  use RentCarsWeb, :view
  alias RentCarsWeb.Api.SpecificationView

  def render("index.json", %{specifications: specifications}) do
    %{data: render_many(specifications, SpecificationView, "specification.json")}
  end

  def render("show.json", %{specification: specification}) do
    %{data: render_one(specification, SpecificationView, "specification.json")}
  end

  def render("specification.json", %{specification: specification}) do
    %{
      id: specification.id,
      name: specification.name,
      description: specification.description
    }
  end
end
