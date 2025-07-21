## Setup

[Development completed using Docker]

From the repo root, run:

```
docker compose build
docker compose up -d
docker compose exec app rails db:setup db:migrate
```

## Import Github issues

Using the [Github API](https://docs.github.com/en/rest/issues/issues?apiVersion=2022-11-28#list-repository-issues) and a [Flexirest](https://github.com/flexirest/flexirest) model, all issues for the `turbogeek421/testing-github-api` repo are fetched and stored locally.

While in a production environment this would be periodically synced via a cron/clock background job, for the purposes of this application it is done via rake task.

If using `zsh`:

```zsh
docker compose exec app rails github:fetch_issues\[365\]
```

or, if using `bash`:

```bash
docker compose exec app rails github:fetch_issues[365]
```

## Setting random states

For the purposes of this application demo all issues can be randomly assigned a state (either `open` or `closed`) and a random user (or unassigned):

```zsh
docker compose exec app rails dev:randomise_issue_states_and_users
```

## Querying local issues

Basic query to get all `Issue` records:

```shell
curl -i -X GET http://localhost:3000/v1/issues
```

(**Note**: Default 50 records per page)

To set page limits and filter by state:

```shell
curl -i -X GET http://localhost:3000/v1/issues \
  -H 'Content-Type: application/json' \
  -d '{"per_page":5,"page":2,"state":"open"}'
```

(**Note**: Maximum 100 records per page)

#### Header information

Via the `api-pagination` gem, custom header have been added for additional information:

|||
|-|-|
|X-Issues-Total-Count|Total record count for the filter given|
|X-Issues-Per-Page|Maximum number of records to be returned for the query|
|X-Issues-Page|The current page number|
