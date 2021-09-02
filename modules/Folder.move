// Copyright 2021 Solarius Intellectual Properties Ky
// Authors: Ville Sundell
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

address {{sender}} {

/// This tao is designed to contain a static array of taos.
/// As with normal tao lifespan, the tao is created with a
/// set of taos, and the same set will be returned when the
/// tao is destroyed.
module Folder {
    #[test]
    use 0x1::Vector;

    /// A simple tao struct containing a vector of taos
    struct Tao<Content> has key, store {
        content: vector<Content>
    }

    /// Create a new tao, with the static set of taos inside it
    public fun new<Content>(content: vector<Content>): Tao<Content> {
        Tao<Content> { content }
    }
    spec new {
        ensures result ==  Tao<Content> { content: content };
    }
    #[test]
    fun test_new() {
        let vec1 = Vector::empty<bool>();
        Vector::push_back<bool>(&mut vec1, true);
        let Tao {content} = new<bool>(vec1);
        let value = Vector::pop_back(&mut content);

        assert(value == true, 123);
    }

    /// Destroy the tao, and return the static set of taos inside it
    public fun extract<Content>(tao: Tao<Content>): vector<Content> {
        let Tao<Content> { content } = tao;
        
        content
    }
    spec extract {
        ensures result == tao.content;
    }
    #[test]
    fun test_extract() {
        let vec1 = Vector::empty<bool>();
        let tao = new<bool>(vec1);
        let content = extract<bool>(tao);

        assert(content == Vector::empty<bool>(), 123);
    }

    spec module {
        // Never abort, unless explicitly defined so:
        pragma aborts_if_is_strict;
    }
}
}