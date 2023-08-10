defmodule RentCarsWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use RentCarsWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate
  import RentCars.AccountsFixtures
  import RentCars.Sessions

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import RentCarsWeb.ConnCase

      alias RentCarsWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint RentCarsWeb.Endpoint
    end
  end

  setup tags do
    RentCars.DataCase.setup_sandbox(tags)
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

  def include_normal_user_token(%{conn: conn}) do
    user = user_fixture()
    password = "123456"
    {:ok, _, token} = create(user.email, password)
    conn = Plug.Conn.put_req_header(conn, "authorization", "Bearer " <> token)
    {:ok, conn: conn, user: user, password: password, token: token}
  end

  def include_admin_token(%{conn: conn}) do
    user = admin_fixture()
    password = "123456"
    {:ok, _, token} = create(user.email, password)
    conn = Plug.Conn.put_req_header(conn, "authorization", "Bearer " <> token)
    {:ok, conn: conn, user: user, password: password, token: token}
  end
end
