# Assigment Three
## Description
This time, we can split task in two subtasks:
* Create container with `nginx`, that on path `/greet` will proxy request to dockerized app from second assigment.
* Prepare docker-compose file, that will launch `nginx` image prepared in previous subtask and dockerized app from first assigment. Nginx should be reachable from port `8080` and app should't be reachable from outside.

### Bonus points
* Add to nginx config section, that will cause it to listen also on port `9001` and return on path `/health` status code indicating success and text `I'm healthy`.