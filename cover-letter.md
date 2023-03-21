Dear reviewers,
​
We are happy to submit the revised version of our paper for
consideration for publication at PLDI'23.
The reviewers' comments were very helpful, and we tried to implement
both the required revisions as well as many of the other suggestions.
We believe that the comments helped us substantially improve the paper.
​
Attached are our revised paper (including appendices where some of the
mandatory revisions happen) and a diff generated by latexdiff.
​
The main changes we made for this revision are listed below. Please
refer to the latexdiff version for other minor changes.

We note that, due to the technical difficulty, we didn't ask latexdiff to diff between figures and typing rules. We will note that the following figure has changed:
<!-- Figure Details here -->


​
## Required revisions

* **Highlight and Modify the Limitation Section**
    Limitation has become our new Section 5. We include the salient limitation we spot and the reviewers pointed out.

    `revision.pdf` Line 613
    `diff.pdf` Line 625
​
* **Improve the presentation in Section 5**
    Section 5 has become Section 6. We have use more standard notations for substitution and function application, and we use named variable alone.
    `revision.pdf` Line 627
    `diff.pdf` Line 639

* **A Fake Agda proof is not friendly to the audience**
    We have rewritten all of the (fake-)Agda proof in the form of more conventional mathematics, provided in the appendix. We also provide more explanation on
    <!-- and emphasize the indispensibility of 
          (but that sentence is not commented out in the latex) -->
    the debruijn indices, universe level and explicit substitution in the appendix for the interested audience. We include a table for all aspects of differences related to sections about FMLTT.

  |                          | General   | Debruijn Index | Explicit Subst | Universe  |
  |--------------------------|-----------|----------------|----------------|-----------|
  | revision.pdf             | Line 627  | Removed        | Removed        | Line 681  |
  | diff.pdf                 | Line 639  | Line 670       | Line 670       | Line 710  |
  | appendix/blindtr.pdf     | Line 1177 | Line 1269      | Line 1269      | Line 1286 |

* **More Introduction for W-type**
    In Section 6, we provide more details about the relationship between W-type and conventional inductive type, and how the former can encode latter.

    `revision.pdf` Line 727
    `diff.pdf` Line 721

* **Connection to work on ML-style modules [DCH 2003, DR 2008]**
    We have add a paragraph about comparison to ML-style modules in related work.

    `revision.pdf` Line 1011
    `diff.pdf` Line 1072

* **Highlight a section for Trusted base**
    We have add one section about the current trusted base of our plugin

    `revision.pdf` Line 606
    `diff.pdf` Line 617
 



## Other changes

<!-- template below 

## Required revisions
​

* **Add the missing steps from the proof of type preservation**
​
    We have added steps (9) (10) (11) (12) in the proof of Lemma B.10, appendix B2.
​
    `revision.pdf`: line 2073
​
* **The explanation about global-labels vs. bound variables**         
    
    We have added in section 4.3 the paragraph under the heading "Term
    variables are more than binders."
​
    `revision.pdf`:   line 503,  
    `diff.pdf`:       line 532
​
* **Clarify about the interplay between term and expression variables, and be explicit about the treatment of binding**
​
    We have edited in section 4.3 the writing that caused confusion:
    we explain how term variables can help express programs that
    otherwise would not type-check due to the requirement that
    checkpoint expressions contain no expression variables.
​
    `revision.pdf`:   line 482,  
    `diff.pdf`:       line 508
​
    We have also clarified in section 5.1 that expression variables can
    transmit data dependence too and that our PDG construction handles it.
​
    `revision.pdf`:   line 635,  
    `diff.pdf`:       line 665 
​
    (The treatment of binding for term variables is addressed by the paragraph
    mentioned in the preceding revision item.)
​
* **A self-contained and non-speculative explanation for how to include dependently-supported distributions, or high-light them as a current limitation that further-work could amend. If this is a limitation, explain whether it's a limitation in expressivity, inference of trace-types, or soundness of the generated guide.**
​
    We have added remarks that clarify that the lack of support for
    dependently supported distributions is a limitation in expressivity,
    and that checkpoints may help incorporate them in the future.
​
    `revision.pdf`:   line 496,  
    `diff.pdf`:       line 525
​
* **Syntactic conditional independence. Please highlight early in the paper: (a)in the abstract, and (b) close to the introduction, for example Section 3.3, that the treatment of conditional independence is syntactic, and a semantic account is left to further work.**
​
	We have highlighted in the abstract that "Guide generation
	extracts and exploits independence structures using a syntactic
	approach to conditional independence, with a semantic account left
	to further work."
​
	`revision.pdf`:   line 14,  
	`diff.pdf`:       line 14
​
	We have noted in section 3.3 that "this treatment of conditional
	independence is syntactic and not proven sound; we leave a semantic
	account to future work."
​
    `revision.pdf`:   line 279,  
    `diff.pdf`:       line 281
​
* **Spell out the construction of the measure spaces**
    
    We have added section 4.4 and appendix A.2, with appendix A.2
    spelling out the construction of the measure spaces.
    We adopt the reviewer's suggestion that measure semantics be given
    only to those programs that are well typed.
​
    `revision.pdf`:   appendix A.2, line 1569  
​
    `revision.pdf`:   section 4.4, line 510,  
    `diff.pdf`:       section 4.4, line 552
​
## Other changes
​
 * **Performance evaluation**
​
    We have gathered more experimental data and updated Table 2 and Figures 18–21.
    The numbers are now averages over multiple runs, and the
    training-loss profiles also show standard deviations.
​
    These new results are consistent with what we reported in the original submission.-->