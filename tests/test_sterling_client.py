from agent.logic.forge.forge_agent import ForgeAgent
from agent.logic.forge.forge_search_engine_strategy import ForgeSearchEngineStrategy
from concurrency.subprocess import Subprocess
import asyncio
import os
import json
from unittest import TestCase

from mock_sterling.test_mock_sterling import MockSterlingClient

class TestSterlingClientConnection(TestCase):
    def __init__(self, methodName="runTest"):
        super().__init__(methodName)
        self.maxDiff = None
        self.default_port = 4000
    
    async def _is_port_listening(self, port: int) -> bool:
        """
        Check if a localhost port is listening for connections.
        """
        try:
            reader, writer = await asyncio.wait_for(
                asyncio.open_connection('127.0.0.1', port), # NOTE: using localhost
                timeout=0.5
            )
            writer.close()
            await writer.wait_closed()
            return True
        except (ConnectionRefusedError, asyncio.TimeoutError, OSError):
            return False

    def test_sterling_client_connection(self) -> None:
        # Mock a ForgeEngineSearchStrategy object
        from unittest.mock import Mock
        from logging import getLogger
        
        engine_strategy = Mock()
        engine_strategy.generate_solver_invocation_command.return_value = [
            "racket", 
            "", # File name will be inserted here dynamically
            "-O", "run_sterling", "serve", 
            "-O", "sterling_port", "4000"
        ]

        # Build the file name
        file_name: str = "/Users/mstu/courses/cs1970/polymath/forge-test.frg"
        
        # Update the mock to use the actual file name
        engine_strategy.generate_solver_invocation_command.return_value[1] = file_name

        agent = ForgeAgent(logger_factory=Mock(), chat_completion=Mock(), engine_strategy=engine_strategy, result_trace=Mock(), collect_pyre_type_information=False)

        # Run `util_communicate_to_sterling_client` on the file name
        exit_code, stdout, stderr = asyncio.run(
            ForgeAgent.util_communicate_to_sterling_client(agent, file_name)
        )

        output_json = json.dump(MockSterlingClient.extract_alloy_json(stdout), indent=2)

        # Print the exit code and output
        print(f"\n{'='*60}")
        print(f"Exit Code: {exit_code}")
        print(f"{'='*60}")
        print(f"Output:\n{output_json}")
        print(f"{'='*60}\n")
        
        # Assertions
        self.assertIsNotNone(solver_output, "Solver output should not be None")
        self.assertEqual(solver_exit_code, 0, "Solver should exit successfully")
