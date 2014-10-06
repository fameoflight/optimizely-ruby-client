# Author:: Hemant Verma <fameoflight@gmail.com>
# Copyright:: 2014 Hemant Verma
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Optimizely
    class Experiment
        def initialize(client)
            @client = client
        end

        def get(experiment_id)
            return @client.get "experiments/#{experiment_id}"
        end

        def create(project_id, description, edit_url, options={})
            options[:description] = description
            options[:edit_url] = edit_url
            return @client.post "projects/#{project_id}/experiments/", options
        end

        def update(experiment_id, options={})
            return @client.put "experiments/#{experiment_id}", options
        end

        def delete(experiment_id)
            return @client.delete "experiments/#{experiment_id}"
        end

        def experiments(project_id)
            return @client.get "projects/#{project_id}/experiments"
        end

        def results(experiment_id)
            return @client.put "experiments/#{experiment_id}/results"
        end

        def variations(experiment_id)
            return @client.get "experiments/#{experiment_id}/variations"
        end
    end
end
