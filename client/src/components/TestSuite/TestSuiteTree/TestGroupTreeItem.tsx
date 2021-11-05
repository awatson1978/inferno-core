import React, { FC, MouseEvent } from 'react';
import { TestGroup, RunnableType } from 'models/testSuiteModels';
import TreeItem from '@mui/lab/TreeItem';
import TreeItemLabel from './TreeItemLabel';
import useStyles from './styles';

export interface TestGroupTreeItemProps {
  testGroup: TestGroup;
  runTests: (runnableType: RunnableType, runnableId: string) => void;
  onLabelClick: (event: MouseEvent<Element>, id: string) => void;
  testRunInProgress: boolean;
}

const TestGroupTreeItem: FC<TestGroupTreeItemProps> = ({
  testGroup,
  runTests,
  onLabelClick,
  testRunInProgress,
}) => {
  const styles = useStyles();

  let sublist: JSX.Element[] = [];
  if (testGroup.test_groups.length > 0) {
    sublist = testGroup.test_groups.map((subTestGroup, index) => (
      <TestGroupTreeItem
        testGroup={subTestGroup}
        runTests={runTests}
        onLabelClick={onLabelClick}
        key={`ti-${testGroup.id}-${index}`}
        testRunInProgress={testRunInProgress}
      ></TestGroupTreeItem>
    ));
  }

  return (
    <TreeItem
      nodeId={testGroup.id}
      label={
        <TreeItemLabel
          runnable={testGroup}
          runTests={runTests}
          testRunInProgress={testRunInProgress}
        />
      }
      onClick={(event) => onLabelClick(event, testGroup.id)}
      classes={{ selected: styles.selectedItem }}
    >
      {sublist}
    </TreeItem>
  );
};

export default TestGroupTreeItem;
