%lang starknet
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.cairo_builtins import (
    HashBuiltin,
    SignatureBuiltin,
)
from starkware.cairo.common.hash import hash2
from starkware.cairo.common.alloc import alloc
from MerkleTreeUtils import MerkleTree

@external
func test_one{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr,
        ecdsa_ptr : SignatureBuiltin*
    }():
    alloc_locals
    let hash_one = 1145740579986834829318467109289126196422112283458566209179034823478827791393
    let hash_two = 3128043887554350334570628527917084743624356612532641151385005685036883923477

    let (hash_three) = MerkleTree.getHash(hash_one,hash_two)
    # Calculated previously
    assert hash_three = 3274240073858950339877966369107462560525003124241902355403880717440512776591

    return ()
end


@external
func test_two{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
    ecdsa_ptr : SignatureBuiltin*,
}():
    alloc_locals
    let (local proofs: felt*) = alloc()
    assert proofs[0] = 222
    assert proofs[1] = 3128043887554350334570628527917084743624356612532641151385005685036883923477

    let proofs_idx = 0
    let proofs_len = 2
    let leaf = 111
     %{expect_revert()%}
    let root = 6969
    let index = 0

    MerkleTree.verify_proof(
        proofs,
        proofs_idx, 
        proofs_len,
        root, 
        leaf, 
        index
    )
    return ()
end

@external
func test_three{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
    ecdsa_ptr : SignatureBuiltin*,
}():
    alloc_locals
    let (local proofs: felt*) = alloc()
    assert proofs[0] = 222
    assert proofs[1] = 3128043887554350334570628527917084743624356612532641151385005685036883923477

    let proofs_idx = 0
    let proofs_len = 2
    let leaf = 111
    let root = 3274240073858950339877966369107462560525003124241902355403880717440512776591
    let index = 0

    MerkleTree.verify_proof(
        proofs,
        proofs_idx, 
        proofs_len,
        root, 
        leaf, 
        index
    )
    return ()
end

# verify_proof_v2(
#     proofs, 
#     0, 
#     len(proofs), 
#     root, 
#     leaf, 
#     index
# )