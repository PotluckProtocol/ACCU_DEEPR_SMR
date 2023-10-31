// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";

interface IRewarder {
    using SafeERC20 for IERC20;

    function onNativeReward(
        uint256 pid,
        address user,
        address recipient,
        uint256 nativeRewardAmount,
        uint256 newLpAmount
    ) external;

    function pendingTokens(
        uint256 pid,
        address user,
        uint256 nativeRewardAmount
    ) external view returns (IERC20[] memory, uint256[] memory);
}

interface IMasterChef {
    using SafeERC20 for IERC20;

    struct UserInfo {
        uint256 amount; // How many LP tokens the user has provided.
        uint256 rewardDebt; // Reward debt. See explanation below.
    }

    struct PoolInfo {
        IERC20 lpToken; // Address of LP token contract.
        uint256 lpSupply; // sum up of supply
        uint256 allocPoint; // How many allocation points assigned to this pool. PEARLs to distribute per block.
        uint256 lastRewardTime; // Last block number that reward token distribution occurs.
        uint256 accRewardPerShare; // Accumulated Reward token per share, times PRECSION_FACTOR (1e12). See below.
        uint256 depositFeeBP; // Deposit Fee
    }

    function rewarders(uint256 index) external view returns (address);

    function poolLength() external view returns (uint256);

    function poolInfo(uint256 pid) external view returns (IMasterChef.PoolInfo memory);

    function userInfo(uint256 _pid, address _user) external view returns (uint256, uint256);

    function totalAllocPoint() external view returns (uint256);

    function rewardsPerSec() external view returns (uint256);

    function pendingRewards(uint256 _pid, address _user) external view returns (uint256);

    function deposit(uint256 _pid, uint256 _amount) external;

    function harvest(uint256 _pid) external;

    function withdrawAndHarvest(uint256 _pid, uint256 _amount) external;

    function depositOnBehalf(
        uint256 _pid,
        uint256 _amount,
        address _to
    ) external;

    function harvestOnBehalf(uint256 _pid, address _to) external;

    function withdrawAndHarvestOnBehalf(
        uint256 _pid,
        uint256 _amount,
        address _to
    ) external;

    function emergencyWithdraw(uint256 _pid) external;
}