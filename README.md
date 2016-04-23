Some example interactions with the API, these won't work if you just copy-paste them as they depend on ids that are determined by the local state of the db.

Creating a submission

```
$ curl -X POST http://localhost:3000/submissions -d '{"submission": {"insured_id": 1, "provider_id": 88, "services": "[{\"code\": \"ZZ91\", \"cost\": 1.23, \"date\": \"2016-04-20T00:00:00-07:00\"}, {\"code\": \"XY333\", \"cost\": 99.3, \"date\": \"2016-04-22T01:08:09-07:00\"}]"}}' -H "X-Api-Key: abc123" -H "Content-Type: application/json" -vv
```

Viewing a submission

```
$ curl -X GET http://localhost:3000/submissions/10 -H "X-Api-Key: abc123internal" -H "Accept: application/json" -vv
```

Viewing a claim

```
$ curl -X GET http://localhost:3000/claims/7 -H "X-Api-Key: abc123internal" -H "Accept: application/json" -vv
```

Updating a claim

```
$ curl -X PATCH http://localhost:3000/claims/7 -d '{"claim": {"status": "in_process", "services_attributes": [{"id": 21, "code": "WW91"}, {"id": 22, "_destroy": true}]}}' -H "X-Api-Key: abc123internal" -H "Content-Type: application/json" -vv
```

Search

```
$ curl -X POST http://localhost:3000/search -d '{"query": {"insured_id": 1, "status": "created", "result_types": ["submission"], "from": "2016-04-20T01:08:09-07:00", "to": "2016-04-22T01:08:09-07:00"}}' -H "X-Api-Key: abc123internal" -H "Content-Type: application/json" -vv
```

