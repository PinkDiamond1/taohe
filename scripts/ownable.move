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

script {
    use TaoHe::Torch;
    use TaoHe::Root;
    use TaoHe::Ownable;

    fun ownable_1(account: signer) {
        Root::create<Ownable::Tao<Torch::Torch>>(&account, Ownable::wrap<Torch::Torch>(@TaoHe, Torch::new()));
    }
}

script {
    use TaoHe::Torch;
    use TaoHe::Root;
    use TaoHe::Ownable;

    fun ownable_2(account: signer) {
        // Extract torch, and wrap it into Root
        Root::create<Torch::Torch>(&account, Ownable::unwrap<Torch::Torch>(&account, Root::extract<Ownable::Tao<Torch::Torch>>(&account)));
    }
}