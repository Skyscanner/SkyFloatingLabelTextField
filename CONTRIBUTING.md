# Contributing to SkyFloatingLabelTextField

If you would like to contribute code you can do so through GitHub by forking the repository and sending a pull request.

When submitting code, please follow existing conventions and style in order to keep readability of the code high.

## Pull requests
*Before* creating a pull request:

* Updated to the latest version of the _master_ branch (and branch out from that to avoid conflicts).
* _SkyFloatingLabelTextField_ and _SkyFloatingLabelTextFieldExample_ schemes compile successfully.
* All unit tests in the _SkyFloatingLabelTextFieldTests_ project pass
* The pull request contains a meaningful description explaining the problem the change solves and how the solution works

*Tests & documentation*

* When adding new functionality all the relevant use cases are covered with new unit tests
* When making bugfixes, the changes covered by new unit tests (or existing ones modified accordingly)
* New files contain the common license header (please see below).
* New classes and methods contain enough documentation to understand their purpose

*After* creating a pull request:

* After validation is completed by Travis CI, the build state is green (meaning both the build succeeded, and all tests pass)

## Issues
If you find a bug in the project (and you don’t know how to fix it), have trouble following the documentation or have a question about the project, then please create an issue. Some tips [from the GitHub Guide](https://guides.github.com/activities/contributing-to-open-source/):

* Check existing issues for the problem you're seeing. Duplicating an issue is slower for both parties so search through open and closed issues to see if what you’re running in to has been addressed already.
* Be clear about what your problem is: what was the expected outcome, what happened instead? Detail how someone else can recreate the problem.
* Include system details like the browser, library or operating system you’re using and its version.
* Paste error output or logs in your issue or in a Gist. If pasting them in the issue, wrap it in three backticks: ``` so that it renders nicely.

## Contact
In case of major changes please feel free to reach out to the maintainers of the project at any time - we will be happy to help.

* Gergely Orosz (gergely.orosz@skyscanner.net, [@GergelyOrosz](https://twitter.com/GergelyOrosz))
* Daniel Langh (daniel.langh@skyscanner.net)
* Raimon Lapuente (raimon.lapuente@skyscanner.net, [@wolffan](https://twitter.com/wolffan))

## License

By contributing your code, you agree to license your contribution under the terms of the APLv2: https://github.com/Skyscanner/SkyFloatingLabelTextField/blob/master/LICENSE.md

All files are released with the Apache 2.0 license.

If you are adding a new file it should have a header like this:

```
//
// Copyright 2016 Skyscanner Limited
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at:
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and limitations under the License.
```
