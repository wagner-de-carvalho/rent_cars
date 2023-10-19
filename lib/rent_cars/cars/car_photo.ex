defmodule RentCars.Cars.CarPhoto do
  use Waffle.Definition
  use Waffle.Ecto.Definition

  @extension_whitelist ~w(.jpg .jpeg .png)

  def validate({file, _}) do
    file_extension =
      file.file_name
      |> Path.extname()
      |> String.downcase()

    case Enum.member?(@extension_whitelist, file_extension) do
      true -> :ok
      false -> {:error, "invalid file type"}
    end
  end

  def storage_dir(_, {_file, car_image}) do
    "uploads/cars/#{car_image.car_id}"
  end
end
