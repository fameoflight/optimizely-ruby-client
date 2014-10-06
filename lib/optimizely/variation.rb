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
    class Variation
        def initialize(client)
            @client = client
        end

        def get(variation_id)
            return @client.get "variations/#{variation_id}"
        end

        def create(experiment_id, description, options={})
            options[:description] = description
            return @client.post "experiments/#{experiment_id}/variations/", options
        end

        def update(variation_id, options={})
            return @client.put "variations/#{variation_id}", options
        end

        def delete(variation_id)
            return @client.delete "variations/#{variation_id}"
        end

        def list(experiment_id)
            return @client.get "experiments/#{experiment_id}/variations"
        end
    end
end
