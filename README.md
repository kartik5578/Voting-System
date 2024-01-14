
# Assigment 2 :- Decentralized Voting System

1. **Build:**

   ```bash
   forge build
   ```

2. **Test:**

   ```bash
   forge test
   ```

## Contract Overview

The `Vote` contract facilitates a basic voting system where candidates can be added, voters can register, and votes can be cast. It includes functionality for starting and stopping an election, checking results, and retrieving voting-related information.

## Variables

- **`owner`**: Address of the contract deployer, assumed to be the owner.
- **`cad_count`**: Counter for candidate IDs.
- **`voter_count`**: Counter for voter IDs.
- **`electionStatus`**: A boolean indicating whether an election is ongoing.
- **`candidateAddress`**: Array holding the addresses of registered candidates.
- **`candidates`**: Mapping from candidate addresses to their details.
- **`votedVoters`**: Array holding addresses of voters who have cast their votes.
- **`votersAddress`**: Array holding addresses of registered voters.
- **`voters`**: Mapping from voter addresses to their details.

## Events

- **`candidateadded`**: Triggered when a new candidate is added.
- **`VoterAdded`**: Triggered when a new voter is registered.

## Constructor

The constructor sets the deployer's address as the owner.

## Functions

### `setCandidate(address _address)`

- **Description**: Adds a new candidate.
- **Modifiers**: Requires that the caller is the owner.
- **Error Handling**: Checks if the caller is the owner.

### `registerUser(address _address)`

- **Description**: Registers a new voter.
- **Error Handling**: Ensures that the voter is not already registered.

### `AddVote(address _cadAddress)`

- **Description**: Allows a registered voter to cast a vote for a candidate.
- **Error Handling**: Checks if the voter is allowed to vote, has not voted before, and the provided candidate address is valid.

### `startElection()`

- **Description**: Starts the election.
- **Modifiers**: Requires that the caller is the owner.
- **Error Handling**: Checks if the caller is the owner and if the election is not already ongoing.

### `stopElection()`

- **Description**: Stops the election.
- **Modifiers**: Requires that the caller is the owner.
- **Error Handling**: Checks if the caller is the owner and if the election is ongoing.

### `Result()`

- **Description**: Retrieves the winner after the election has ended.
- **Error Handling**: Ensures that the election has ended.

### `getTotalVotes(address _address)`

- **Description**: Retrieves the total votes received by a candidate.

### `getVoterVoted(address _address)`

- **Description**: Checks if a voter has cast a vote.
