defmodule RentCars.Specifications do
  @moduledoc """
  The Specifications context.
  """

  import Ecto.Query, warn: false
  alias RentCars.Repo

  alias RentCars.Specifications.Specification

  @doc """
  Returns the list of specifications.

  ## Examples

      iex> list_specifications()
      [%Specification{}, ...]

  """
  def list_specifications do
    Repo.all(Specification)
  end

  @doc """
  Gets a single specification.

  Raises `Ecto.NoResultsError` if the Specification does not exist.

  ## Examples

      iex> get_specification!(123)
      %Specification{}

      iex> get_specification!(456)
      ** (Ecto.NoResultsError)

  """
  def get_specification!(id), do: Repo.get!(Specification, id)

  @doc """
  Creates a specification.

  ## Examples

      iex> create_specification(%{field: value})
      {:ok, %Specification{}}

      iex> create_specification(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_specification(attrs \\ %{}) do
    %Specification{}
    |> Specification.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a specification.

  ## Examples

      iex> update_specification(specification, %{field: new_value})
      {:ok, %Specification{}}

      iex> update_specification(specification, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_specification(%Specification{} = specification, attrs) do
    specification
    |> Specification.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a specification.

  ## Examples

      iex> delete_specification(specification)
      {:ok, %Specification{}}

      iex> delete_specification(specification)
      {:error, %Ecto.Changeset{}}

  """
  def delete_specification(%Specification{} = specification) do
    Repo.delete(specification)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking specification changes.

  ## Examples

      iex> change_specification(specification)
      %Ecto.Changeset{data: %Specification{}}

  """
  def change_specification(%Specification{} = specification, attrs \\ %{}) do
    Specification.changeset(specification, attrs)
  end
end
