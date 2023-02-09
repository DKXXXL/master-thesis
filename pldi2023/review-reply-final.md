We thank all the reviewers for their critical and encouraging feedback.
Below we address the main concerns, which we may have paraphrased for brevity.

* (A, B, C, D) __There are limitations with the current design and implementation, such as
  restricting induction to the top level and the awkwardness in handling terms like `denoteTy t`.__

  We will clearly state the current limitations. We believe the limitations
  identified by the reviewers represent interesting opportunities for future research.
  For example, future work could explore a normalization algorithm for an
  extended dependent type theory that admits more conversion equations on
  elimination of extensible inductive types, as well as proof assistant
  implementations that natively support extensible inductive types and thus
  streamline normalization for open terms.

  We will also add a comment about the trusted base of any developments using the
  plugin, as the reviewers suggested.
  
* (A, B, D) **The presentation of FMLTT is tough.**

  We sympathize with the reviewers. We will expand the section to clarify things
  in response to the reviewers' questions. We will also use an appendix to
  explain the formalization and proofs in greater detail.


* (B, C) __Consistency is already implied for FMLTT by a translation to MLTT, and for FPOP by a translation to Coq__.

  We agree with the reviewers' insights.

  We note that the effort required to prove consistency directly for FMLTT is
  similar to that required to prove type preservation for a translation to MLTT:
  both proofs are structured as type-preserving interpretations
  into another dependent type theory.


* (B, D) __The plugin implementation is not included as a supplement.__

  We will ensure the release of our research artifacts for public access.


* (A) __Connection to work on ML-style modules [DCH 2003, DR 2008]?__

  Thank you for the references.
  Both ML-style modules and our families are modularity mechanisms.
  ML-style modules are more about abstraction (caring about issues such as
  signature ascription), while our families are more about extensibility.
  Both use singletons to model and control the propagation of
  definitions inside a module or family.
  Work on mixin composition for ML-style modules focuses on making 
  mixins play well with the peculiarities of ML-style modules,
  while our work focuses on supporting mixins in the presence of extensible
  inductive types.


* (B) __Rules TYEQ/PK/ADD and LSIG/ADD do not seem to prescribe how to choose $A$.__

  The FMLTT typing rules do not commit to a particular choice of the context type $A$,
  though there exists a simple algorithm for picking the right $A$ (lines 785–787): a
  field is checked in a context of type $A$ that hides W-type signatures behind
  $\mathbb{U}$, unless that field invokes a constructor or eliminator of some
  W-type. Intuitively, the type system is sound without this algorithm because
  it restricts the ways a field can be used if a wrong $A$ is chosen.



* (B) __What happens if the programmer tries to mix contradictory language features?__

  We expect mixing two contradictory developments to cause the plugin to
  generate unprovable proof obligations (cf. line 386). One example is mixing
  HM-style polymorphism and references, which the reviewer mentioned. Another
  example is mixing fixpoints into a family that proves strong normalization for
  STLC.


* (D) __What happens if a user tries to use `tm_rect` with standard pattern matching?__

  The programmer is prevented from using `tm_rect` within the family in which `tm` is defined,
  because the plugin makes `tm` appear in the typing context as an axiomatized
  type without exposing its concrete definition (line 494).
 

* (D) __What does it mean to place a new field using annotations?__

  We clarify this using the following example.
  The programmer uses the annotation `Inherit a2` to indicate that the new field
  `b` should be placed immediately after the existing field `a2`.

  ```C
  Family A.
    FDefinition a1 := ....
    FDefinition a2 := ....
    FDefinition c := ....
  End A.
  
  Family B extends A.
    Inherit a2.
    FDefinition b := ...
  End B.
  ```

* (D) __Line 487__ ("a module named `STLC◦subst◦Cases` is generated interactively ...") __is confusing.__

  We wanted to emphasize that programming is interactive even within an `FRecursion` definition:
  the programmer need not wait until the entire `FRecursion` definition is completed to have
  their `Case` commands checked and translated by the plugin.

* (D) __Out of curiosity, how does your plugin integrate with universes?__

  We do not have intimate knowledge of Coq's universe polymorphism feature, but we expect
  it to have the same level of compatibility with families as it does with Coq
  modules—under the hood, upon closing a family, the plugin is just doing
  module inclusion and instantiation repeatedly.


We will address in our revision other reviewer comments not mentioned above.
Again, we thank all the reviewers for their thoughtful and detailed comments, which will help improve the paper.