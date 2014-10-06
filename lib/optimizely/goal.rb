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
    class Goal
        def initialize(client)
            @client = client
        end

        def get(goal_id)
            return @client.get "goals/#{goal_id}"
        end

        def create(project_id, title, goal_type, options={})
            options[:title] = description
            options[:goal_type] = goal_type
            return @client.post "projects/#{project_id}/goals/", options
        end

        def update(goal_id, options={})
            return @client.put "goals/#{goal_id}", options
        end

        def delete(goal_id)
            return @client.delete "goals/#{goal_id}"
        end
    end
end
