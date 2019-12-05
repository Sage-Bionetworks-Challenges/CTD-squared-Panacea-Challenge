#!/usr/bin/env cwl-runner
#
# Score
#
cwlVersion: v1.0
class: CommandLineTool
baseCommand: [Rscript, /usr/local/bin/score.R]

hints:
  DockerRequirement:
    dockerPull: docker.synapse.org/syn20968332/scoring_harness:v3

inputs:
  - id: inputfile
    type: File
  - id: goldstandard
    type: File
  - id: round
    type: string
  - id: metric
    type: string
  - id: check_validation_finished
    type: boolean?

arguments:
  - valueFrom: $(inputs.inputfile.path)
    prefix: --inputfile
  - valueFrom: $(inputs.goldstandard.path)
    prefix: --goldstandard
  - valueFrom: results.json
    prefix: --results
  - valueFrom: $(inputs.round)
    prefix: --round
  - valueFrom: $(inputs.metric)
    prefix: --metric

requirements:
  - class: InlineJavascriptRequirement
     
outputs:
  - id: results
    type: File
    outputBinding:
      glob: results.json
