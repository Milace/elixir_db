defmodule JobQuantum do
  @moduledoc """
  This module contain funtions executed from cron jobs
  """
  import CursoElixirDb.HelperAccounts

  @doc """
   Crear y actualiza un archivo .txt en la ruta tmp/
  """
  def print_text(path, msg) do
    fun = &(&1 + 1)
    write = &(&2 |> File.write("#{&1}"))

    if File.exists?(path) do
      path |> File.read! |> String.to_integer |> fun.() |> printp(msg) |> write.(path)
    else
      path |> File.open!([:write]) |> File.close
      path |> File.write("0")
    end
  end

  defp printp(number, msg) do
    IO.inspect(msg <> "#{number}")
    number
  end

  @doc """
   Inserta datos en la base de datos
  """
  def insert_data() do
    create_accounts(%{type_document: "CC",
                      num_document: 1113519072,
                      email: "mlceballos@personalsoft.com.co",
                      name_company: "personalsoft",
                      name: "Milthon",
                      last_name: "Ceballos"
                    })
  end


end
