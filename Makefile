prod_build_release:
	mix deps.get --only prod
	MIX_ENV=prod mix compile
#	cd assets && brunch build --production && cd ..
	MIX_ENV=prod mix phx.digest
	MIX_ENV=prod mix release

prod_create_schema: 
	docker exec -ti mspf_postgres_1 /bin/bash -c "PGPASSWORD=postgres psql -h localhost -U postgres -tc \"SELECT 1 FROM pg_database WHERE datname = 'foo_prod'\" | grep -q 1 || PGPASSWORD=postgres psql -U postgres -c \"CREATE DATABASE foo_prod WITH OWNER=postgres\""

prod_migrate:
	_build/prod/rel/foo/bin/foo migrate 

prod_seed:
	_build/prod/rel/foo/bin/foo seed

prod_run: 
	_build/prod/rel/foo/bin/foo console 

dev_build_release:
	mix deps.get 
	MIX_ENV=dev mix compile
#	cd assets && brunch build --production && cd ..
	#MIX_ENV=dev mix phx.digest
	MIX_ENV=dev mix release

dev_create_schema: 
	docker exec -ti mspf_postgres_1 /bin/bash -c "PGPASSWORD=postgres psql -h localhost -U postgres -tc \"SELECT 1 FROM pg_database WHERE datname = 'foo_dev'\" | grep -q 1 || PGPASSWORD=postgres psql -U postgres -c \"CREATE DATABASE foo_dev WITH OWNER=postgres\""

dev_migrate:
	_build/prod/rel/foo/bin/foo migrate 

dev_seed:
	_build/prod/rel/foo/bin/foo seed

dev_run: 
	_build/prod/rel/foo/bin/foo console 
