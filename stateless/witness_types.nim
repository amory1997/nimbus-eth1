import nimcrypto/[keccak, hash], stew/bitops2

type
  TrieNodeType* = enum
    BranchNodeType
    Branch17NodeType
    ExtensionNodeType
    AccountNodeType
    HashNodeType

  AccountType* = enum
    SimpleAccountType
    ExtendedAccountType

proc setBranchMaskBit*(x: var uint, i: int) {.inline.} =
  assert(i >= 0 and i < 17)
  x = x or (1 shl i).uint

func branchMaskBitIsSet*(x: uint, i: int): bool {.inline.} =
  assert(i >= 0 and i < 17)
  result = ((x shr i.uint) and 1'u) == 1'u

func constructBranchMask*(b1, b2: byte): uint {.inline.} =
  result = uint(b1) shl 8 or uint(b2)
  if countOnes(result) < 2:
    debugEcho "MASK: ", result
  assert(countOnes(result) > 1)
