This is basic Ruby client for [Optimizely Rest API](http://developers.optimizely.com/rest/).  This require you to generate API token. Please visit [token page](http://www.optimizely.com/tokens) to get your token. 


# Supported Models and Operations
* Project
	* List
	* get
	* create
	* update
	* experiments
	* create goal
* Experiment
	* get
	* create
	* update
	* delete
	* experiments
	* results
	* variations 
* Variation
	* get
	* create
	* update
	* delete
	* list
* Goal
	* get
	* create
	* update
	* delete


## Usage
```
require 'lib/optimizely'

client = Optimizely::Client 'abcdefghijklmnopqrstuvwxyz:123456'

```



## Lets list out all the projects 


```
project = Optimizely::Project client

project.list

```

## Create new project

```
project.create 'New Project from Ruby API Client'

```


