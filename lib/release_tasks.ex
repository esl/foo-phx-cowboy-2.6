defmodule Foo.ReleaseTasks do
  @start_apps [
    :crypto,
    :logger,
    :ssl,
    :postgrex,
    :ecto
  ]

  def myapp, do: Application.get_application(__MODULE__)

  def repos, do: Application.get_env(myapp(), :ecto_repos, [])

  defmacro run_task(do: block) do
    quote do
      me = myapp()

      IO.puts("Loading #{me}..")
      Application.load(me)

      IO.puts("Starting dependencies..")
      Enum.each(@start_apps, &Application.ensure_all_started/1)

      IO.puts("Starting repos..")
      Enum.each(repos(), & &1.start_link(pool_size: 1))

      unquote(block)

      IO.puts("Success!")
      :init.stop()
    end
  end

  def seed do
    run_task do
      _migrate()
      IO.puts("Running seed script ")
      Enum.each(repos(), &run_seeds_for/1)
    end
  end

  def migrate do
    run_task do
      IO.puts("Runing migrations..")
      _migrate()
    end
  end

  def _migrate, do: Enum.each(repos(), &run_migrations_for/1)

  def priv_dir(app), do: "#{:code.priv_dir(app)}"

  defp run_migrations_for(repo) do
    app = Keyword.get(repo.config, :otp_app)
    IO.puts("Running migrations for #{app}")
    Ecto.Migrator.run(repo, migrations_path(repo), :up, all: true)
  end

  def run_seeds_for(repo) do
    # Run the seed script if it exists
    seed_script = seeds_path(repo)

    if File.exists?(seed_script) do
      IO.puts("Running seed script..")
      Code.eval_file(seed_script)
    end
  end

  def migrations_path(repo), do: priv_path_for(repo, "migrations")

  # Capture the mix environment at build time
  defmacro mix_build_env() do
    Atom.to_string(Mix.env())
  end

  def seeds_path(repo) do
    mix_env = mix_build_env()
    IO.puts("Loading seeds file for env: #{inspect(mix_env)}")
    priv_path_for(repo, mix_env <> "_seeds.exs")
  end

  def priv_path_for(repo, filename) do
    app = Keyword.get(repo.config, :otp_app)
    repo_underscore = repo |> Module.split() |> List.last() |> Macro.underscore()
    Path.join([priv_dir(app), repo_underscore, filename])
  end
end
