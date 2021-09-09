*Repository Archived and moved to Bitbucket*
==================

Concourse Teams Notification Resource
==================

Sends alerts to Teams.
This resource sends the result of builds to a incoming webhook in MS Teams.

Resource Type Configuration
---------------------------

```yml
resource_types:
- name: teams-notification
  type: docker-image
  source:
    repository: trecnoc/concourse-teams-resource
    tag: latest
```

Source Configuration
--------------------

The following fields are required if you want to see erroring Concourse task output in the Teams notification:

- url: The MS Teams incoming webhook URL

Example resource config:

```yml
resources:
- name: teams-alert
  type: teams-notification
  source:
    url: ((teams_webhook))
```

Behaviour
--------

### Sends alert to teams.

Send alert to teams with the configured parameters.

#### Parameters

Required:

- `status`: 'failure' or 'success' for whether resource is called under on_failure or on_success.

Optional:

- `message`: A custom message to display
- `message_file`: The location of a file to use as the message instead (this parameter is always preferred over `message` if set)

Example
-------

```yml
on_failure: # or on_success:
        do:
        - put: teams-alert
          params:
            status: failure #or status: success
            message: My custom message #or message_file: my-filename.txt
```

See our sample [test-pipeline.yml](test-pipeline.yml) for a working example.

Testing
-------

To test this resource, either:

1. Using test-pipeline, add resource, resource type, and on_failure/on_success examples to an existing pipeline, or

2. install a test Concourse with Docker.

Push the sample pipeline to it (remember to update the Teams resource configuration options first, as appropriate):

``` sh
fly login -t local -c http://localhost:8080 -u <local-username> -p <local-password>
fly -t local set-pipeline -p test -c test-pipeline.yml
```

Browse http://localhost:8080 and run the monitoring-test job. One of the tasks in that job is supposed to succeed, and one is supposed to fail. Note the Teams put: on the failing job. This should now trigger, so check Teams for an incoming alert.

Inside the alert message you should find pipeline, job_name, concourse_build_url and output fields which contain the logs from failed or succeeded jobs.
