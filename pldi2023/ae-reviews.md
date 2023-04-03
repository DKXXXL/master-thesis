PLDI 2023 Artifacts Paper #3 Reviews and Comments
===========================================================================
Paper #3 Extensible Metatheory Mechanization via Family Polymorphism


Review #3A
===========================================================================
* Updated: 1 Apr 2023 10:47:26am AoE

Badge
-----
5. Reusable

Expertise
---------
2. Knowledgeable: I know something about this area

Comments for authors
--------------------
First of all, I would like to thank the authors for their prompt responses during the kick-the-tires phase. I suggest the *Reusable* badge as I believe the artifact lives up to the standards we expect although there still remain some minor issues.

I followed the instructions provided by the authors and was able to build all of their proofs and showcases *without using Docker* on my M1 Mac. I encountered the same situation as Reviewer C did: `Analysis_showcase{,2}.v` took around 3x the expected time; it didn't immediately terminate after `Print Analysis_showcase.LangCP.` It's not the case when using VSCoq interactively.

I feel that there are some bugs when using the Coq plugin *interactively*. For example, when I tried to execute `Interpret To End` (Ctrl + Alt + End) in `Analysis_showcase.v`, VSCoq showed me 231 errors. The first error is on Line 707 concerning `Overridable Field join_monoton`:

```
Exception Info: Nametab.GlobalizationError(_)
The reference join was not found in the current environment.
Error Happens during translation
   Definition join_monoton :
  forall x y l,
  self__AbsExpData.le x y -> self__AbsExpData.le (join l x) (join l y) :=
  non_implement
Stack Trace 
Raised by primitive operation at Fampoly_plugin__Utils.CoqVernacUtils.emit_vernac_exprs.emit_vernac_expr in file "src/utils.ml", line 226, characters 56-80
Called from Fampoly_plugin__Utils.CoqVernacUtils.runVernac in file "src/utils.ml", line 286, characters 14-37
Called from Fampoly_plugin__Famprogram.add_overridable_field in file "src/famprogram.ml", line 568, characters 4-74
Called from Vernacextend.vtdefault.(fun) in file "vernac/vernacextend.ml", line 136, characters 29-33
Called from Vernacinterp.interp_typed_vernac in file "vernac/vernacinterp.ml", line 20, characters 20-113
```

But when I changed to `Step Forward` (Alt + Down), the error disappeared. The only error I could not bypass is produced by the `Extraction` command:

```
Error: Anomaly "Missing opaque with identifier 20"
Please report at http://coq.inria.fr/bugs/.
```

I understand that it appears to be a Coq internal error and may not be the authors' fault. I can interpret to the end of the file after commenting out `Extraction`s and fiddling a lot. Nevertheless, I confirmed that extraction works with `coqc` and the extracted OCaml code works with `utop`.

When reviewing the source code, I feel kind of confused by the directory structure. I infer that there are four parts included in this artifact (the authors didn't state it clearly in `README.md`; please correct if there is any inaccuracy):

1. `src/` contains the Coq plugin implemented in OCaml;
2. `theories/` contains the plugin loader and some Coq libraries the authors would like to use in 3. or 4.;
3. `showcase_test/` contains the Coq examples and case studies in the paper which rely on Coq plugin;
4. `test/` contains extra test programs that the authors didn't mention so we can safely ignore.

I also noticed some mismatches between the paper and the artifact. Reviewer B has written a list of detailed suggestions. I didn't find more so I have no additional comments. Anyway, in my opinion, the code in the artifact has demonstrated their contributions in the paper and is reusable in potential follow-up work.

P.S. I found the artifact does not work on the latest version of Coq (8.17.0) and/or OCaml (4.14.1). I quite like your work on extensible mechanization and am looking forward to being able to use it on the latest version of Coq/OCaml.



Review #3B
===========================================================================
* Updated: 31 Mar 2023 8:42:58am AoE

Badge
-----
5. Reusable

Expertise
---------
2. Knowledgeable: I know something about this area

Comments for authors
--------------------
Dear authors,

  I was able to complete the review of the artifact. After the successful first-phase review, where it was possible to compile every .v file, I proceed with the following:
  - I managed to use the plugin in Emacs, to interactively follow the proofs. I fully understand that the provided README.md file invites the reviewer to try this mode using VSCode Docker Remote + VSCoq, not emacs. So, I am aware that the following suggestions may not be correct, since they could be based on wrong impressions from an incorrect configuration of the tool in emacs, from my part. Also, I wanted to note that, beyond the following observations, the tool is an impressive feat, that seems to be incredible helpful for future development of mechanized theories, and I understand that it is also an ongoing effort.
    - As is already mentioned in the README.md file, the compilation process generates a lot of debug dump, which in emacs seems to be shown in the *response* buffer. Normally, in emacs, that buffer is used to display information about the success or failure of a compilation step, helping in debugging problems, but also, helping to understand what is actually being defined after the successful execution of a statement. Now, on a successful compilation, it seems to be informing about the definition of every element that composes the translation of the actual code into Coq. I understand that, in some occasions, that would be helpful. But since, sometimes, the concepts presented by Fampoly are expressed in terms of huge amounts of Coq definitions, the returned info displayed in the *response* buffer may actually confuse a person that is trying to compile and reason just about Fampoly code/concepts. This may have a negative impact in the quality of the interactive proof experience. 
    - Some goals do not seem to be displayed in terms of the written Fampoly expressions. For example, in file STLC_families.v, line 371, `FInduction free_var_matters`. Each conjunct of the goal is defined in terms of internals like `__handler_type_ht_var` (and the same with `app`, `abs`, and `unit`). I imagine that in more complex goals, exposing these internals may complicate the interactive edition of proofs.
    - The correspondence between the code shown on paper and the actual code provided is not as direct as some people may desire. Besides minor differences in the name of each element of the provided case studies, some concepts are actually defined using different Fampoly constructions than those shown in the paper, that also are not introduced in it. This could complicate the understanding of the provided case studies.
    - Related with the previous, in section 3.6, paragraph `Partial recursors`, the paper says: `Partial recursors are automatically generated for all inductive types defined with FInductive`. While, in the provided example, they are actually obtained by means of using explicitly the command `FScheme`, after the `FInductive` definition. If I am understanding correctly, this is a minor difference, but it could be useful to change the cited sentence from the paper, to better help future users of the tool.
    - With regard to the implementation of the abstract interpreters, I must point out that it is actually difficult to review them. The provided mechanization contains in a single file (for example, in `Analysis_showcase.v`) several of the artifacts mentioned in the paper (not only the interpreters), with no documentation that would help to distinguish the different parts of the file. The names of each component of the mechanization not always coincide with what is presented in the paper. I strongly suggest to better document the showcase examples, and/or to better harmonize the content of the paper with what is in the source of the case studies.
    - Nonetheless, I am in favor of considering the artifact to be reusable: the source code of the provided `Fampoly` plugin, beyond being clearly functional, is generally well-documented, and together with the provided paper, they could help future research into reusing the contributions made by this work.



Review #3C
===========================================================================
* Updated: 3 Apr 2023 5:16am AoE

Badge
-----
5. Reusable

Expertise
---------
2. Knowledgeable: I know something about this area

Comments for authors
--------------------
In thIn this artifact, the authors provide a plugin capable of type-checking Family Polymorphism. To check this plugin we were given several proof scripts that use the feature. These proof scripts can be verified using coqc, and users can interact with them using an extension such VSCoq.

Overall, I found that everything was functional and the files were well documented.
The `README` guide was very helpful to show how the artifact works, specially after being accompanied with the extra instructions provided by the authors during the discussion period. 
However, I believe there could be more details in the README file for someone that wants to modify and extend the system.

Therefore, I consider the current artifact **Reusable** but I would like to see some minor changes to the zenodo artifact until the end of the artifact evaluation period.

These changes include:
- Add the explanations provided in the author communication about running the artifact without the docker container;
- Provide a description of the file structure with comments about each of the directories and the files within them - maybe take this opportunity to check all the files (e.g., `family_ops.ml` seems to be empty);
- Change `FPOPtest1.tar` to `FPOPtest.tar` or update the commands in the README file.

Thank you to the authors for their commitment in presenting a high quality artifact.



Comment @A1 by Ende Jin <ende.jin@uwaterloo.ca>
---------------------------------------------------------------------------
__Dear Reviewer B__:

Please try to type `#use` instead of `# use` (no space). 

Generally, the interactive command lines will look like below:
```
root@5022f99254c9:/home/FPOP/testoutput# ls
test1.ml  test1.mli  test2.ml  test2.mli  test3.ml  test3.mli
root@5022f99254c9:/home/FPOP/testoutput# utop
...
Welcome to utop version 2.11.0 (using OCaml version 4.13.1)!
...
Type #utop_help for help about using utop.
...
utop # #use "test2.ml";;
...
  end
module LangCPTesing :
  sig
    val testcase1 :
      'a -> Analysis_showcase.Coq_v_UU56de_4015.AI.literals option
    val testcase2 :
      'a -> Analysis_showcase.Coq_v_UU56de_4015.AI.literals option
...
utop # LangCPTesing.testcase1();;
- : Analysis_showcase.Coq_v_UU56de_4015.AI.literals option =
Some (Analysis_showcase.Coq_v_UU56de_4015.AI.Coq___internal_natlit 1)
```

Notice at the line using `#use "test2.ml";;`, no space between hashtag and use, and don't forget the double semi-colon in utop interactive terminal.

__Dear Reviewer A and C__:

Thanks for the feedback! I confirm there is a large RAM and CPU usage, but the reply from Reviewer B makes me believe the OOM issue can be avoided on Linux/Intel platform.

I will try to pack a source code version, and a setup guide for Mac Users, to lower the memory cost by emulation from docker.

I also want to mention that due to the difference between machines and OS, the running time can be different. The time usage we attach in the guide might only make sense in a machine I specified earlier in the guide. (Sorry again for not testing on different OSes and different CPUs!).


Comment @A2 by Ende Jin <ende.jin@uwaterloo.ca>
---------------------------------------------------------------------------
**For reviewer A/C**:

While I am trying to make a complete set of instructions, the main gist of the instructions would be: 

1. try to just move the FPOP directory out of docker directly into your Mac Machine. 
(Of course I suggest you to first use `dune clean` to remove unnecessary binary files before moving out).

2. (Effectful operation) The setup of the environment should reflect solely on the opam list displayed in the docker. In other words, we only need opam to pin the below version of the software.
```
ocaml-base-compiler   4.13.1
coq                   8.15.0
```
the utop I am using is 
```
utop                  2.11.0
```
3. now you can use dune build on the FPOP source code and then try to run the commandlines about `coqc`

Please reply if bumped into any question, and at the meantime I will setup a series of instruction for those who are unfamiliar with opam setup and stuff.

What's more, I also suggest review A/C try to test the runnable files on VSCode section and Extraction section. Because these files are independent to each other and can be tested on their own.

**For Reviewer C:**
ALT + ↓ stands for `step forward` in Coq interactive programming on Linux platform. I am not sure the correspondence on Mac but I think "Command Pallette" for VSCode will have a complete set of instructions that VSCoq supports, that will definitely include `Coq: Step Forward` command.

Also with respect to the docker thing, 
>... angry_lamarr and a second one with dreamy_hoover ...

the two items should stand for the containers, not related to the image I disclose to you. Generally speaking, everytime we run a docker image, a new container will be created (unless you removed it), and the history of the operations you did to the container will stay with the container.

(Basically everytime `docker run -i -t fpopeval` is runned, a new container is created, and VSCode only look at container there)

These two containers should mean you have initiated our image twice. You can attach VSCode to either of the container as you want.


Comment @A3 by Ende Jin <ende.jin@uwaterloo.ca>
---------------------------------------------------------------------------
__Dear Reviewer A/C,__

Hello. I attach the source code zip file and setup guide for building and testing here. Please reply if you found any bump or difficulty. I hope building from source can lower the cost of running docker for Mac User to run our artifact successfully, but I cannot guarantee it.

What's more, I also have to point out that, __the VSCoq section does not entirely depend on the success of compilation section__. Even if the compilation of `Analysis_example.v` fails due to  OOM issue, it should still possible to evaluate VSCode section for `Analysis_example.v` .  VSCoq section should be runnable once `dune build` succeeded (i.e. the initial stage of the given docker image).

It is just at the point where the compilation fails, the VSCoq session should also fail due to OOM issue.


Comment @A4 by Reviewer B
---------------------------------------------------------------------------
Dear Author,
thank you very much for the response! I was, indeed, introducing the wrong command into `utop`. I am now able to load the extracted OCaml files.


Comment @A5 by Reviewer C
---------------------------------------------------------------------------
Dear authors,

Thank you for addressing our comments!

**Verifying proofs - all working**

Using the zip file provided and the following the steps in `setup-1.md` I was able to run all the individual scripts for verifying the proofs and also run the `testshowcase.sh` file.
However, for the first two examples (Analysis_showcase, Analysis_showcase2) something strange is happening. After printing all the definitions the processes don’t finish right away and stay running for an additional time of 5-15 mins without printing anything on the screen. Is this usual behavior? All the other examples run with similar times to the ones reported in the artifact documentation, so these 2 are the only exceptions.

**VSCode extension - error coqtop**

While testing the VSCode extension with the files under the `showcase_test` folder, the highlighting occurs but the side panel of ProofView is emitting an error that does not allow me to interact with the proof. The error in the panel is `coqtop is not running`, and the pop-up error has the message `Could not start coqtop (coqtop)`. Do you have any ideas on how to fix this?


Comment @A6 by Ende Jin <ende.jin@uwaterloo.ca>
---------------------------------------------------------------------------
Dear Reviewer C,

Thanks for continuing trying out our artifact!

**About VSCoq Error**
I am curious if this error is related to our plugin. If you open another proof script that doesn't use our plugin, can you successfully proof-check it interactively? If you are still experiencing issues, it may be related to the MacOS and VSCoq configuration. I apologize that I am not well-versed in MacOS development environments to offer any specific suggestions, but I am happy to assist in any way I can.

**About Verifying Proof:**
Regarding the Analysis_showcase, I would like to clarify that I haven't come across similar issues in our development. As you can see from the proof script , the print definition is the last command, and I am uncertain about the cause of the pause on your machine. Perhaps you can try running the script interactively with VSCoq (once you can make VSCoq work) to check if the final print statement is the one that is taking an extra 5-15 minutes.

Finally, as Reviewer B pointed out and tried, our plugin is loosely coupled with VSCoq plugin so trying our plugin with emacs should also work. If the reviewers are more familiar with working in an emacs environment, I would definitely suggest trying it out.


Comment @A7 by Reviewer C
---------------------------------------------------------------------------
Dear authors,

I just wanted to let you know that I was able to successfully use the VSCode extension after cleaning all the previous containers and executing the steps in the instructions again.

From what I got, the side view sometimes shows the message `coqtop is not running`, I am still not sure why, but after some time the error disappears. Also, I was only able to run the `Step Forward` command after running the command `Interpret to point`.

I will provide my full review shortly.
