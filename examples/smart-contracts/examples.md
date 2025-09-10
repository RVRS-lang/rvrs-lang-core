# RVRS Example Smart Contracts

This catalog shows examples of smart contracts currently possible in RVRS with the existing evaluation engine.  
They demonstrate branching, variable declarations, flow calls, and symbolic outputs.

---

## 1. Ritual Token Burn
Symbolic validator checking moon phase and secret code before granting a blessing.  
Tests branching, multiple inputs, success/fail outputs.

**Code**
```rvrs
flow main {
  delta sender: Str = "addr1-sacrificer"
  delta nftId: Num = 101
  delta moonPhase: Str = "full"
  delta secretCode: Num = 999

  call verifyRitual with sender, nftId, moonPhase, secretCode
}

flow verifyRitual with sender, nftId, moonPhase, secretCode {
  branch moonPhase == "full" and secretCode == 999 then {
    echo "ritual accepted"
    mouth "blessing granted"
  } else {
    echo "ritual failed"
    mouth "burn failed"
  }
}
```

---

## 2. Simple Payment Gate
Validates whether a sender has provided enough funds.

**Code:**
```rvrs
flow main {
  delta sender: Str = "addr1-carlos"
  delta amount: Num = 50
  call checkPayment with sender, amount
}

flow checkPayment with sender, amount {
  branch amount >= 50 then {
    echo "payment accepted"
    mouth "access granted"
  } else {
    echo "payment rejected"
    mouth "access denied"
  }
}
```

---

## 3. Multi-Step Ritual (Chained Calls)
Tests sequential flow calls and cumulative execution.

**Code:**
```rvrs
flow main {
  call stepOne
}

flow stepOne {
  echo "step one complete"
  call stepTwo
}

flow stepTwo {
  echo "step two complete"
  mouth "ritual complete"
}
```

---

## 4. Ownership Check
Confirms that the sender matches the stored owner.

**Code:**
```rvrs
flow main {
  delta sender: Str = "addr1-hero"
  delta owner: Str = "addr1-hero"
  call verifyOwner with sender, owner
}

flow verifyOwner with sender, owner {
  branch sender == owner then {
    mouth "ownership confirmed"
  } else {
    mouth "not owner"
  }
}
```

---

## 5. Simple Escrow Release
Releases funds to seller upon confirmation.

**Code:**
```rvrs
flow main {
  delta buyer: Str = "addr1-alice"
  delta seller: Str = "addr1-bob"
  delta confirm: Bool = True

  call releaseEscrow with buyer, seller, confirm
}

flow releaseEscrow with buyer, seller, confirm {
  branch confirm == True then {
    mouth "funds released to seller"
  } else {
    mouth "funds locked"
  }
}
```

---

## 6. Bounded Counter
Prevents execution if a counter exceeds a limit.

**Code:**
```rvrs
flow main {
  delta count: Num = 3
  call checkCount with count
}

flow checkCount with count {
  branch count < 5 then {
    echo "counter valid"
    mouth "continue"
  } else {
    echo "counter exceeded"
    mouth "halt"
  }
}
```

---
