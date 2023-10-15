defmodule RentCars.Accounts.Avatar do
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

  def storage_dir(_, {_file, user}), do: "uploads/accounts/users/#{user.id}"
end
