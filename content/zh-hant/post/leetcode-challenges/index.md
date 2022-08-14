---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "我的 Leetcode 挑戰"
subtitle: ""
summary: "Leetcode 刷題解答"
authors: [Zane]
tags: [Leetcode]
categories: [程式語言]
date: 2020-03-10T17:20:29+08:00
lastmod: 2020-03-10T17:20:29+08:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---

## 1. Two Sums

```python
def twoSum(self, nums, target):
    """
    :type nums: List[int]
    :type target: int
    :rtype: List[int]
    """
    for i, v in enumerate(nums):
        # get the remainder
        rem = target - v
        # mark the chosen number
        nums[i] = 'x'
        # get the index of the remainder
        if rem in nums:
            return [i, nums.index(rem)]
```

Runtime: **940 ms**, faster than **31.55%** of Python3 online submissions for Two Sum.
Memory Usage: **13.8 MB**, less than **66.13%** of Python3 online submissions for Two Sum.

---

## 771. Jewels and Stones

```python
def numJewelsInStones(self, J: str, S: str):
    count = 0
    # count jewels
    for i in J:
        count += S.count(i)
    return count
```

Runtime: **36 ms**, faster than **96.62%** of Python3 online submissions for Jewels and Stones.
Memory Usage: **13 MB**, less than **81.19%** of Python3 online submissions for Jewels and Stones.

---

## 938. Range Sum of Binary Search Tree

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None
def rangeSumBST(self, root: TreeNode, L: int, R: int):
    if not root:
        return 0
    elif root.val >= L and root.val <= R:
        return root.val + self.rangeSumBST(root.left, L, R) + self.rangeSumBST(root.right, L, R)
    elif root.val < L:
        return self.rangeSumBST(root.right, L, R)
    else:
        return self.rangeSumBST(root.left, L, R)
```

Runtime: **224 ms**, faster than **92.03%** of Python3 online submissions for Range Sum of BST.
Memory Usage: **21.7 MB**, less than **58.38%** of Python3 online submissions for Range Sum of BST.

---

## 1021. Remove Outermost Parentheses

```python
def removeOuterParentheses(self, S: str):
    count = shift = 0
    res = ''

    # calculate the range which will be saved
    for i, p in enumerate(S):
        if p == '(':
            count += 1
        else:
            count -= 1
        if count == 0:
            res += S[shift + 1: i]
            shift = i + 1
    return res
```

Runtime: **44 ms**, faster than **87.14%** of Python3 online submissions for Remove Outermost Parentheses.
Memory Usage: **13.3 MB**, less than **34.04%** of Python3 online submissions for Remove Outermost Parentheses.

---

## 709. To Lower Case

```python
def toLowerCase(self, str: str):
    return str.lower()
```

Runtime: **20 ms**, faster than **99.99%** of Python3 online submissions for To Lower Case.
Memory Usage: **13.1 MB**, less than **50.92%** of Python3 online submissions for To Lower Case.

---

## 804. Unique Morse Code Words

```python
def uniqueMorseRepresentations(self, words: List[str]):
    morse_code = [".-", "-...", "-.-.", "-..", ".", "..-.", "--.",
                  "....", "..", ".---", "-.-", ".-..", "--", "-.",
                  "---", ".--.", "--.-", ".-.", "...", "-", "..-",
                  "...-", ".--", "-..-", "-.--", "--.."]

    # make it unique
    res = {''.join([morse_code[ord(c) - ord('a')] for c in word]) for word in words}
    # print(res)
    return len(res)
```

Runtime: **36 ms**, faster than **95.38%** of Python3 online submissions for Unique Morse Code Words.
Memory Usage: **13.1 MB**, less than **60.02%** of Python3 online submissions for Unique Morse Code Words.

---

## 905. Sort Array By Parity

```python
def sortArrayByParity(self, A: List[int]):
    return sorted(A, key=lambda i: i % 2 == 0, reverse=True)
```

Runtime: **60 ms**, faster than **99.35%** of Python3 online submissions for Sort Array By Parity.
Memory Usage: **13.8 MB**, less than **26.77%** of Python3 online submissions for Sort Array By Parity.

---

## 961. N-Repeated Element in Size 2N Array

```python
def repeatedNTimes(self, A: List[int]):
    d = {i: 0 for i in set(A)}
    for i in A:
        d[i] += 1

    d = sorted(d.items(), key=lambda kv: kv[1], reverse=True)

    reutur d[0][0]
```

Runtime: **84 ms**, faster than **13.09%** of Python3 online submissions for N-Repeated Element in Size 2N Array.
Memory Usage: **14.3 MB**, less than **20.81%** of Python3 online submissions for N-Repeated Element in Size 2N Array.

```python
def repeatedNTimes(self, A: List[int]) -&gt; int:
    return collections.Counter(A).most_common(1)[0][0]
```

Runtime: **52 ms**, faster than **63.96%** of Python3 online submissions for N-Repeated Element in Size 2N Array.
Memory Usage: **14.2 MB**, less than **42.24%** of Python3 online submissions for N-Repeated Element in Size 2N Array.

```python
def repeatedNTimes(self, A: List[int]):
    for i in range(1, len(A)):
        for j in range(len(A) - i):
            if A[j] == A[j+i]:
                return A[j]
```

Runtime: **44 ms**, faster than **97.71%** of Python3 online submissions for N-Repeated Element in Size 2N Array.
Memory Usage: **14.3 MB**, less than **25.22%** of Python3 online submissions for N-Repeated Element in Size 2N Array.

---

## 832. Flipping an Image

```python
def flipAndInvertImage(self, A: List[List[int]]):
    # reverse list
    for byte in A:
        for bit in range(len(byte) // 2):
            byte[bit], byte[-1 - bit] = byte[-1 - bit], byte[bit]

    # invert list
    for byte in A:
        for bit in range(len(byte)):
            if byte[bit] == 0:
                byte[bit] = 1
            else:
                byte[bit] = 0
    return A
```

Runtime: **48 ms**, faster than **84.59%** of Python3 online submissions for Flipping an Image.
Memory Usage: **13.1 MB**, less than **73.11%** of Python3 online submissions for Flipping an Image.

```python
def flipAndInvertImage(self, A):
    for row in A:
        for i in range((len(row) + 1) // 2):
            """
            In Python, the shortcut row[~i] = row[-i-1] = row[len(row) - 1 - i]
            helps us find the i-th value of the row, counting from the right.
            """
            row[i], row[~i] = row[~i] ^ 1, row[i] ^ 1
    return A
```

Runtime: **44 ms**, faster than **97.98%** of Python3 online submissions for Flipping an Image.
Memory Usage: **13.3 MB**, less than **12.00%** of Python3 online submissions for Flipping an Image.

---

## 977. Squares of a Sorted Array

```python
def sortedSquares(self, A: List[int]):
    for i, v in enumerate(A):
        A[i] = v * v

    return sorted(A)
```

Runtime: **148 ms**, faster than **96.46%** of Python3 online submissions for Squares of a Sorted Array.
Memory Usage: **14.5 MB**, less than **81.96%** of Python3 online submissions for Squares of a Sorted Array.

---

## 929. Unique Email Addresses

```python
def numUniqueEmails(self, emails: List[str]):
    for i, v in enumerate(emails):
        # split email to local and domain name
        email = v.split('@')
        # remove '.' char
        local_name = email[0].replace('.', '')
        # ignore string  after '+' char
        if '+' in local_name:
        local_name = local_name[:local_name.index('+')]
        # reconstruct the email
        emails[i] = local_name + '@' + email[1]

    # make email list be unique
    return len(set(emails))
```

Runtime: **40 ms**, faster than **99.44%** of Python3 online submissions for Unique Email Addresses.
Memory Usage: **13.2 MB**, less than **41.53%** of Python3 online submissions for Unique Email Addresses.

---

## 657. Robot Return to Origin

```python
def judgeCircle(self, moves: str):
    return moves.count('U') == moves.count('D') and moves.count('R') == moves.count('L')
```

Runtime: **32 ms**, faster than **99.78%** of Python3 online submissions for Robot Return to Origin.
Memory Usage: **13.4 MB**, less than **10.24%** of Python3 online submissions for Robot Return to Origin.

---

## 461. Hamming Distance

```python
def hammingDistance(self, x: int, y: int):
    x = '{0:032b}'.format(x)
    y = '{0:032b}'.format(y)

    counter = 0
    for i in range(len(x)):
        if x[i] != y[i]:
            counter += 1
    return counter
```

Runtime: **28 ms**, faster than **99.50%** of Python3 online submissions for Hamming Distance.
Memory Usage: **13.4 MB**, less than **5.25%** of Python3 online submissions for Hamming Distance.

```python
def hammingDistance(self, x: int, y: int) -&gt; int:
    # convert to bin format
    x = format(x, 'b')
    y = format(y, 'b')

    # unify length
    if len(x) &gt; len(y):
        y = (str(0) * (len(x) - len(y))) + y
    else:
        x = (str(0) * (len(y) - len(x))) + x

    counter = 0
    for i in range(len(x)):
        if x[i] != y[i]:
            counter += 1

    return counter
```

Runtime: **32 ms**, faster than **97.37%** of Python3 online submissions for Hamming Distance.
Memory Usage: **13.1 MB**, less than **64.64%** of Python3 online submissions for Hamming Distance.

---

## 617. Merge Two Binary Trees

```python
def mergeTrees(self, t1: TreeNode, t2: TreeNode):
    if not (t1 and t2):
        return t1 or t2
    t1.val = t1.val + t2.val
    t1.left = self.mergeTrees(t1.left, t2.left)
    t1.right = self.mergeTrees(t1.right, t2.right)
    return t1
```

Runtime: **80 ms**, faster than **98.72%** of Python3 online submissions for Merge Two Binary Trees.
Memory Usage: **13.8 MB**, less than **65.04%** of Python3 online submissions for Merge Two Binary Trees.

---

## 728. Self Dividing Numbers

```python
def selfDividingNumbers(self, left: int, right: int):
    res = []
    for i in range(left, right + 1):
        i_to_str = str(i)
        for c in i_to_str:
            if c == '0' or i % int(c) &gt; 0:
            break
        else:
            res.append(i)
    return res
```

Runtime: **48 ms**, faster than **95.37%** of Python3 online submissions for Self Dividing Numbers.
Memory Usage: **13.3 MB**, less than **19.87%** of Python3 online submissions for Self Dividing Numbers.

```python
def selfDividingNumbers(self, left: int, right: int):
    res = []
    for i in range(left, right + 1):
        curr = i
        while curr:
            mod = curr % 10
            if mod == 0 or i % mod &gt; 0:
                break
            if curr == mod:
                res.append(i)
            curr = curr // 10
    return res
```

Runtime: **40 ms**, faster than **99.68%** of Python3 online submissions for Self Dividing Numbers.
Memory Usage: **13 MB**, less than **75.83%** of Python3 online submissions for Self Dividing Numbers.

---

## 942. DI String Match

```python
def diStringMatch(self, S: str) -&gt; List[int]:
    left = len(S)
    right = 0
    res = []
    for s in S:
        if s == 'I':
            res.append(right)
            right += 1
        else:
            res.append(left)
            left -= 1
    return res + [left]
```

Runtime: **76 ms**, faster than **100.00%** of Python3 online submissions for DI String Match.
Memory Usage: **14.2 MB**, less than **64.84%** of Python3 online submissions for DI String Match.

---

## 944. Delete Columns to Make Sorted

```python
def minDeletionSize(self, A: List[str]):
    count = 0
    for col in zip(*A):
        if list(col) != sorted(col):
        count += 1
    return count
```

Runtime: **92 ms**, faster than **99.06%** of Python3 online submissions for Delete Columns to Make Sorted.
Memory Usage: **13.5 MB**, less than **83.51%** of Python3 online submissions for Delete Columns to Make Sorted.

---

## 1051. Height Checker

```python
def heightChecker(self, heights: List[int]):
    count = 0
    sorted_heights = sorted(heights)

    for i in range(len(heights)):
        if sorted_heights[i] != heights[i]:
            count += 1
    return count
```

Runtime: **28 ms**, faster than **97.52%** of Python3 online submissions for Height Checker.
Memory Usage: **13.2 MB**, less than **100.00%** of Python3 online submissions for Height Checker.

---

## 933. Number of Recent Calls

```python
class RecentCounter:
    def __init__(self):
        self.q = collections.deque()

    def ping(self, t):
        self.q.append(t)
        while and self.q[0] < t-3000:
            self.q.popleft()
        return len(self.q)
```

Runtime: **192 ms**, faster than **96.49%** of Python3 online submissions for Number of Recent Calls.
Memory Usage: **17.8 MB**, less than **36.42%** of Python3 online submissions for Number of Recent Calls.

---

## 561. Array Partition I

```python
def arrayPairSum(self, nums: List[int]):
    sorted_nums = sorted(nums)

    sum = 0
    for i in range(1, len(sorted_nums), 2):
        sum += min(sorted_nums[i - 1], sorted_nums[i])

    return sum
```

Runtime: **96 ms**, faster than **78.18%** of Python3 online submissions for Array Partition I.
Memory Usage: **14.9 MB**, less than **81.43%** of Python3 online submissions for Array Partition I.

```python
def arrayPairSum(self, nums: List[int]):
    return sum(sorted(nums)[::2])
```

Runtime: **88 ms**, faster than **98.12%** of Python3 online submissions for Array Partition I.
Memory Usage: **15 MB**, less than **47.54%** of Python3 online submissions for Array Partition I.

---

## 700. Search in a Binary Search Tree

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    res = None
    def searchBST(self, root: TreeNode, val: int):
        if root == None:
            return

        if root.val == val:
            return root
        elif val < root.val:
            return self.searchBST(root.left, val)
        else:
            return self.searchBST(root.right, val)
```

Runtime: **76 ms**, faster than **98.37%** of Python3 online submissions for Search in a Binary Search Tree.
Memory Usage: **15.2 MB**, less than **70.35%** of Python3 online submissions for Search in a Binary Search Tree.

---

## 344. Reverse String

```python
def reverseString(self, s: List[str]):
    """
    Do not return anything, modify s in-place instead.
    """
    s = s.reverse()
```

Runtime: **156 ms**, faster than **98.99%** of Python3 online submissions for Reverse String.
Memory Usage: **17.8 MB**, less than **28.10%** of Python3 online submissions for Reverse String.

```python
def reverseString(self, s: List[str]):
    """
    Do not return anything, modify s in-place instead.
    """
    for i in range(len(s) // 2):
        s[i], s[~i] = s[~i], s[i]
```

Runtime: **160 ms**, faster than **96.82%** of Python3 online submissions for Reverse String.
Memory Usage: **17.6 MB**, less than **74.60%** of Python3 online submissions for Reverse String.

---

## 104. Maximum Depth of Binary Tree

```python
def maxDepth(self, root: TreeNode):
    if not root:
        return 0
    else:
        return 1 + max(self.maxDepth(root.left), self.maxDepth(root.right))
```

Runtime: **40 ms**, faster than **98.38%** of Python3 online submissions for Maximum Depth of Binary Tree.
Memory Usage: **15.3 MB**, less than **71.96%** of Python3 online submissions for Maximum Depth of Binary Tree.

---

## 136. Single Number

```python
def singleNumber(self, nums: List[int]):
    res = nums[0]

    for i in range(1, len(nums)):
        res = res ^ nums[i]

    return res
```

Runtime: **40 ms**, faster than **88.77%** of Python3 online submissions for Single Number.
Memory Usage: **14.7 MB**, less than **78.28%** of Python3 online submissions for Single Number.

---

## 412. Fizz Buzz

```python
def fizzBuzz(self, n: int):
    res = []
    for i in range(1, n + 1):
        if i % 3 == 0 and i % 5 == 0:
            res.append('FizzBuzz')
        elif i % 3 == 0:
            res.append('Fizz')
        elif i % 5 == 0:
            res.append('Buzz')
        else:
            res.append(str(i))
    return res
```

Runtime: **56 ms**, faster than **78.08%** of Python3 online submissions for Fizz Buzz.
Memory Usage: **14.2 MB**, less than **45.92%** of Python3 online submissions for Fizz Buzz.

---

## 206. Reverse Linked List

```python
def reverseList(self, head: ListNode):
    if not head or not head.next:
        return head
    p = self.reverseList(head.next)
    head.next.next = head
    head.next = None
    return p
```

Runtime: **36 ms**, faster than **95.40%** of Python3 online submissions for Reverse Linked List.
Memory Usage: **19 MB**, less than **13.04%** of Python3 online submissions for Reverse Linked List.

```python
def reverseList(self, head: ListNode):
    prev, curr = None, head
    while curr:
        curr.next, prev, curr = prev, curr, curr.next
    return prev
```

Runtime: **36 ms**, faster than **95.40%** of Python3 online submissions for Reverse Linked List.
Memory Usage: **14.4 MB**, less than **72.19%** of Python3 online submissions for Reverse Linked List.

---

## 283. Move Zeroes

```python
def moveZeroes(self, nums: List[int]):
    """
    Do not return anything, modify nums in-place instead.
    """
    for i in range(len(nums)):
        for j in range(i, len(nums)):
            if nums[i] == 0:
                nums[i], nums[j] = nums[j], nums[i]
```

Runtime: **2604 ms**, faster than **5.03%** of Python3 online submissions for Move Zeroes.
Memory Usage: **14.3 MB**, less than **95.18%** of Python3 online submissions for Move Zeroes.

```python
def moveZeroes(self, nums: List[int]):
    """
    Do not return anything, modify nums in-place instead.
    """
    for i in range(len(nums) - 1, -1, -1):
        if nums[i] == 0:
            nums.append(nums.pop(i))
```

Runtime: **48 ms**, faster than **85.34%** of Python3 online submissions for Move Zeroes.
Memory Usage: **14.4 MB**, less than **70.20%** of Python3 online submissions for Move Zeroes.

```python
def moveZeroes(self, nums: List[int]):
    """
    Do not return anything, modify nums in-place instead.
    """
    j = -1
    for i in range(len(nums)):
        if nums[i] != 0:
            j += 1
            nums[i], nums[j] = nums[j], nums[i]
```

Runtime: **48 ms**, faster than **85.34%** of Python3 online submissions for Move Zeroes.
Memory Usage: **14.4 MB**, less than **74.97%** of Python3 online submissions for Move Zeroes.

---

## 237. Delete Node in a Linked List

```python
def deleteNode(self, node):
    """
    :type node: ListNode
    :rtype: void Do not return anything, modify node in-place instead.
    """
    if node:
        node.val = node.next.val
        node.next = node.next.next
```

Runtime: **40 ms**, faster than **93.24%** of Python3 online submissions for Delete Node in a Linked List.
Memory Usage: **13.5 MB**, less than **78.23%** of Python3 online submissions for Delete Node in a Linked List.

---

## 13. Roman to Integer

```python
def romanToInt(self, s: str) -> int:
    roman = {
        'I':  1,
        'V':  5,
        'X':  10,
        'L':  50,
        'C':  100,
        'D':  500,
        'M':  1000
    }

    sum = prev_num = 0
    for c in s:
        if roman[c] > prev_num:
            sum -= 2 * prev_num
        sum += roman[c]
        prev_num = roman[c]
    return sum
```

Runtime: **52 ms**, faster than **96.69%** of Python3 online submissions for Roman to Integer.
Memory Usage: **13.2 MB**, less than **71.14%** of Python3 online submissions for Roman to Integer.

---

## 242. Valid Anagram

```python
def isAnagram(self, s: str, t: str):
    return ''.join(sorted(s)) == ''.join(sorted(t))
```

Runtime: **60 ms**, faster than **61.86%** of Python3 online submissions for Valid Anagram.
Memory Usage: **14 MB**, less than **26.12%** of Python3 online submissions for Valid Anagram.

```python
class Solution:
    def isAnagram(self, s: str, t: str):
        return collections.Counter(s) == collections.Counter(t)
```

Runtime: **44 ms**, faster than **92.83%** of Python3 online submissions for Valid Anagram.
Memory Usage: **13.2 MB**, less than **89.68%** of Python3 online submissions for Valid Anagram.

---

## 217. Contains- Duplicate

```python
def containsDuplicate(self, nums: List[int]):
    return len(nums) &gt; len(set(nums))
```

Runtime: **36 ms**, faster than **97.37%** of Python3 online submissions for Contains Duplicate.
Memory Usage: **18.8 MB**, less than **69.92%** of Python3 online submissions for Contains Duplicate.

---

## 7. Reverse-Integer

```python
class Solution:
    MAX_POSITIVE =  (2 ** 31 ) - 1
    MAX_NEGATIVE = - (2 ** 31)

    def reverse(self, x):
        if x == 0:
            return x
        # reversed string of the number
        s = (str(abs(x))[::-1]).lstrip('0')
        # integerize
        i = int(s) if x > 0 else -(int(s))
        # check overflow
        if self.MAX_NEGATIVE <= i <= self.MAX_POSITIVE:
            return i
        return 0
```

Runtime: **32 ms**, faster than **96.26%** of Python3 online submissions for Reverse Integer.
Memory Usage: **14 MB**, less than **5.26%** of Python3 online submissions for Reverse Integer.

---

## 9. Palindrome Number

```python
class Solution:
    def isPalindrome(self, x: int) -&gt; bool:
        s = str(x)
        for i in range(len(s) // 2):
            if s[i] != s[~i]:
                return False
        return True
```

Runtime:** 64 ms**, faster than **82.89%** of Python3 online submissions for Palindrome Number.
Memory Usage: **12.7 MB**, less than **100.00%** of Python3 online submissions for Palindrome Number.

---

## 122. Best Time to Buy and Sell Stock II

```python
class Solution:
    def maxProfit(self, prices: List[int]) -&gt; int:
        profit = 0
        for i in range(len(prices) - 1):
            if prices[i + 1] &gt; prices[i]:
                profit += prices[i + 1] - prices[i]
        return profit
```

Runtime: **64 ms**, faster than **91.94%** of Python3 online submissions for Best Time to Buy and Sell Stock II.
Memory Usage: **13.8 MB**, less than **90.24%** of Python3 online submissions for Best Time to Buy and Sell Stock II.

---

## 14. Longest Common Prefix

```python
class Solution:
    def longestCommonPrefix(self, strs: List[str]) -&gt; str:
        if not strs:
            return ''
        result = ''
        for i, v in enumerate(strs[0]):
            result += v
            for s in strs[1:]:
                if not s.startswith(result):
                    return result[:i]
        return result
```

Runtime: **32 ms**, faster than **93.72%** of Python3 online submissions for Longest Common Prefix.
Memory Usage: **12.8 MB**, less than **100.00%** of Python3 online submissions for Longest Common Prefix.

---

## 108. Convert Sorted Array to Binary Search Tree

```python
class Solution:
    def sortedArrayToBST(self, nums: List[int]) -&gt; TreeNode:
        if not nums:
            return
        index = len(nums) // 2
        node = TreeNode(nums[index])

        left = nums[:index]
        right = nums[index+1:]

        node.left = self.sortedArrayToBST(left)
        node.right = self.sortedArrayToBST(right)

        return node
```

Runtime: **68 ms**, faster than **92.38%** of Python3 online submissions for Convert Sorted Array to Binary Search Tree.
Memory Usage: **15 MB**, less than **100.00%** of Python3 online submissions for Convert Sorted Array to Binary Search Tree.

---

## 171. Excel Sheet Column Number

```python
class Solution:
    def titleToNumber(self, s: str) -&gt; int:
        result = 0
        x = {chr(65 + i): i + 1 for i in range(26)}
        for i, v in enumerate(list(s)):
            result += (26 ** (len(s) - i - 1)) * x[v.upper()]
        return result
```

Runtime: **28 ms**, faster than **95.62%** of Python3 online submissions for Excel Sheet Column Number.
Memory Usage: **12.8 MB**, less than **100.00%** of Python3 online submissions for Excel Sheet Column Number.

---

## 387. First Unique Character in a String

```python
from collections import OrderedDict

class Solution:
    def firstUniqChar(self, s: str) -&gt; int:
        result = -1
        words = OrderedDict()
        for c in (list(s)):
            if c not in words:
                words[c] = 1
            else:
                words[c] += 1

        for i, v in enumerate(words.items()):
            print(i, v)
            if v[1] == 1:
                result = s.index(v[0])
                break
        return result
```

Runtime: **124 ms**, faster than **64%** of Python3 online submissions for First Unique Character in a String.
Memory Usage: **13 MB**, less than **100.00%** of Python3 online submissions for First Unique Character in a String.

```python
class Solution:
    def firstUniqChar(self, s: str) -&gt; int:
        # build hash map : character and how often it appears
        count = collections.Counter(s)

        # find the index
        for idx, ch in enumerate(s):
            if count[ch] == 1:
                return idx
        return -1
```

Runtime: **80 ms**, faster than **90.43%** of Python3 online submissions for First Unique Character in a String.
Memory Usage: **12.8 MB**, less than **100.00%** of Python3 online submissions for First Unique Character in a String.

---

## 371. Sum of Two Integers

```python
class Solution:
    def getSum(self, a: int, b: int) -&gt; int:
        return sum([a,b])
```

Runtime: **24 ms**, faster than **96.24%** of Python3 online submissions for Sum of Two Integers.
Memory Usage: **12.6 MB**, less than **100.00%** of Python3 online submissions for Sum of Two Integers.

---

## 21. Merge Two Sorted Lists

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def mergeTwoLists(self, l1: ListNode, l2: ListNode) -> ListNode:
        pre_head = ListNode(-1)
        curr = pre_head

        while l1 and l2:
            if l1.val<l2.val:
                curr.next = l1
                l1 = l1.next
            else:
                curr.next = l2
                l2 = l2.next
            curr = curr.next

        if l1: curr.next = l1
        if l2: curr.next = l2

        return pre_head.next
```

Runtime: **28 ms**, faster than **98.99%** of Python3 online submissions for Merge Two Sorted Lists.
Memory Usage: **12.8 MB**, less than **100.00%** of Python3 online submissions for Merge Two Sorted Lists.

---

## 1295. Find Numbers with Even Number of Digits

```python
class Solution:
    def findNumbers(self, nums: List[int]) -> int:
        count = 0
        limitValue = 10 ** 5

        if 1 <= len(nums) <= 500:
            for i in nums:
                if i <= limitValue and len(str(i)) % 2 == 0:
                    count = count + 1
            return count
        else:
            raise
```

Runtime: **44 ms**, faster than **97.79%** of Python3 online submissions for Find Numbers with Even Number of Digits.
Memory Usage: **12.6 MB**, less than **100.00%** of Python3 online submissions for Find Numbers with Even Number of Digits.
