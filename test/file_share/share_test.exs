defmodule FileShare.ShareTest do
  use FileShare.DataCase

  alias FileShare.Share

  describe "files" do
    alias FileShare.Share.File

    import FileShare.ShareFixtures

    @invalid_attrs %{name: nil, path: nil, password: nil}

    test "list_files/0 returns all files" do
      file = file_fixture()
      assert Share.list_files() == [file]
    end

    test "get_file!/1 returns the file with given id" do
      file = file_fixture()
      assert Share.get_file!(file.id) == file
    end

    test "create_file/1 with valid data creates a file" do
      valid_attrs = %{name: "some name", path: "some path", password: "some password"}

      assert {:ok, %File{} = file} = Share.create_file(valid_attrs)
      assert file.name == "some name"
      assert file.path == "some path"
      assert file.password == "some password"
    end

    test "create_file/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Share.create_file(@invalid_attrs)
    end

    test "update_file/2 with valid data updates the file" do
      file = file_fixture()
      update_attrs = %{name: "some updated name", path: "some updated path", password: "some updated password"}

      assert {:ok, %File{} = file} = Share.update_file(file, update_attrs)
      assert file.name == "some updated name"
      assert file.path == "some updated path"
      assert file.password == "some updated password"
    end

    test "update_file/2 with invalid data returns error changeset" do
      file = file_fixture()
      assert {:error, %Ecto.Changeset{}} = Share.update_file(file, @invalid_attrs)
      assert file == Share.get_file!(file.id)
    end

    test "delete_file/1 deletes the file" do
      file = file_fixture()
      assert {:ok, %File{}} = Share.delete_file(file)
      assert_raise Ecto.NoResultsError, fn -> Share.get_file!(file.id) end
    end

    test "change_file/1 returns a file changeset" do
      file = file_fixture()
      assert %Ecto.Changeset{} = Share.change_file(file)
    end
  end
end
